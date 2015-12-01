class Dataset < ActiveRecord::Base

  belongs_to :model
  belongs_to :user

  validates_inclusion_of :status, :in => %w{ pending processing processed failed }

  after_initialize :init
  after_create :queue_job

  def process
    begin
      raise 1.inspect
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

end