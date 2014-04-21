class Notification < ActionMailer::Base

  def welcome(user)
    @user = user
    mail(:from => "Translating Time <translatingtime2@gmail.com>", :to => user.rfc822, :subject => "Welcome to Translating Time")
  end

  def reset(user)
    @user = user
    mail(:from => "Translating Time <translatingtime2@gmail.com>", :to => user.rfc822, :subject => "Your password has been reset")
  end

  def inquiry(inquiry)
    @inquiry = inquiry
    mail(:from => "Translating Time <translatingtime2@gmail.com>", :to => 'TranslatingTime2@gmail.com', :subject => "Website Inquiry")
  end
  
end