class Admin::ConfidenceController < Admin::ApplicationController

  def edit
    if request.post?
      FileUtils.mv(params[:image].path, "#{Rails.root}/public/images/confidence.jpg")
      flash[:success] = 'Updated your confidence images'
      redirect_to admin_confidence_path
    end
  end

end
