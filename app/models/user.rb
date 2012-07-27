class User < ActiveRecord::Base

  devise :database_authenticatable, :recoverable, :rememberable
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me
  
  validates_presence_of :first_name, :last_name, :email
  validates_presence_of :password, :on => :create
  
  def full_name
    "#{first_name} #{last_name}"
  end

end