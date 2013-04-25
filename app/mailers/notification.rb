class Notification < ActionMailer::Base

  def welcome(user)
    @user = user
    mail(:from => "Translating Time <notifications@translatingtime.net>", :to => user.rfc822, :subject => "Welcome to Translating Time")
  end

  def reset(user)
    @user = user
    mail(:from => "Translating Time <notifications@translatingtime.net>", :to => user.rfc822, :subject => "Your password has been reset")
  end

  def inquiry(inquiry)
    @inquiry = inquiry
    mail(:from => "Translating Time <notifications@translatingtime.net>", :to => 'TranslatingTime2@gmail.com', :subject => "Website Inquiry")
  end
  
end