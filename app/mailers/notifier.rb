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

end
