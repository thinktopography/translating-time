class User < ActiveRecord::Base

  devise :database_authenticatable, :recoverable, :rememberable
  
  attr_accessible :first_name, :last_name, :email, :role_id, :password, :password_confirmation, :remember_me
  
  belongs_to :role
  
  validates_presence_of :first_name, :last_name, :email, :role_id
  validates_uniqueness_of :email
  
  after_create :welcome
  
  def full_name
    "#{first_name} #{last_name}"
  end

  def rfc822
    "#{self.full_name} <#{self.email}>"
  end
  
  def is_admin?
    self.role_id <= 1
  end
  
  def is_publisher?
    self.role_id <= 2
  end
  
  def is_editor?
    self.role_id <= 3
  end
  
  def welcome
    set_temp_password
    self.save
    #Notification.welcome(self).deliver!
  end

  def reset_password
    set_temp_password
    self.save
    #Notification.reset(self).deliver!
  end
  
  private
  
    def set_temp_password
      self.password = SecureRandom.hex(6).to_s.upcase[0,6]
      self.password_confirmation = self.password
      self.change_password = true
    end

end