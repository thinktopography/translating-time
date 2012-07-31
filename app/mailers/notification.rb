class Notification < ActionMailer::Base

  def welcome(user)
    @user = user
    mail(:from => "notifications@translatingtime.net", :to => user.rfc822, :subject => "Welcome to Translating Time")
  end

  def reset(user)
    @user = user
    mail(:from => "notifications@translatingtime.net", :to => user.rfc822, :subject => "Your password has been reset")
  end
  
end