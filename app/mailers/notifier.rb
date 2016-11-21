class Notifier < ApplicationMailer

  def success(dataset)
    mail(:from => "Translating Time <greg@thinktopography.com>", :to => dataset.user.email, :subject => 'Your dataset was successfully processed') do |format|
      format.html { render :text => 'Success!' }
    end
  end

  def failure(dataset)
    mail(:from => "Translating Time <greg@thinktopography.com>", :to => dataset.user.email, :subject => 'Your dataset was unable to be processed') do |format|
      format.html { render :text => 'Failed!' }
    end
  end

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
