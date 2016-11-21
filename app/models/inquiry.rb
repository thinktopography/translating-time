class Inquiry < ActiveRecord::Base

  # attr_accessible :name, :affiliation, :email, :comments

  validates_presence_of :name, :affiliation, :email, :comments

  after_create :send_inquiry


  private

    def send_inquiry
      Notifier.inquiry(self).deliver!
    end
end
