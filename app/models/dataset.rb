class Dataset < ActiveRecord::Base

  belongs_to :model
  belongs_to :user
  has_many :estimates

  validates_presence_of :model_id, :user_id
  validates_inclusion_of :status, :in => %w{ pending processing processed failed }

  after_initialize :init
  after_create :queue_job
  after_save :enforce_active

  def process
    self.status = 'processing'
    self.save
    begin
      observations = Observation.export
      File.open("#{Rails.root}/tmp/process.r", 'w') { |file| file.write(self.model.source) }
      File.open("#{Rails.root}/tmp/observations.txt", 'w') { |file| file.write(observations) }
      system("cd #{Rails.root}/tmp;RScript ./process.r")
      data = File.read("#{Rails.root}/tmp/estimates.txt")
      Import.new(self, data, 'value').process
      File.unlink("#{Rails.root}/tmp/process.r")
      File.unlink("#{Rails.root}/tmp/observations.txt")
      File.unlink("#{Rails.root}/tmp/estimates.txt")
      succeed
    rescue
      fail
    end
    return true
  end

  def succeed
    Notifier.success(self).deliver!
    self.status = 'processed'
    self.save
  end

  def fail
    Notifier.failure(self).deliver!
    self.status = 'failed'
    self.save
  end

  private

    def queue_job
      Delayed::Job.enqueue ProcessDataset.new(self.id)
    end

    def init
      self.status ||= 'pending'
    end

    def enforce_active
      if self.is_active
        Dataset.where('id != ?', self.id).update_all(:is_active, false)
      end
    end

end