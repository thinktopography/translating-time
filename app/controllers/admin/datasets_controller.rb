class Admin::DatasetsController < Admin::ApplicationController

  def index
    @datasets = Dataset.order(:created_at => :desc).all
  end

  def show
    @dataset = Dataset.find(params[:id])
    @estimates = @dataset.estimates
    @species = Species.order("name ASC").all
    @events = Event.order("name ASC").all
    @grid = {}
    @estimates.each do |estimate|
      @grid[estimate.species_id] = {} if @grid[estimate.species_id].blank?
      @grid[estimate.species_id][estimate.event_id] = estimate
    end
    respond_to do |format|
      format.csv {
        send_data(render_to_string('show'), :filename => "dataset-#{@dataset.id}-export.csv", :type => "text/csv", :disposition => "inline") and return
      }
      format.html { render 'show' }
    end
  end
  
  def new
    @dataset = Dataset.new
  end

  def compare
    params[:compare] ||= { :threshold => 0}
    if request.post?
      @estimates1 = {}
      @estimates2 = {}
      @dataset1 = Dataset.find(params[:compare][:dataset1_id])
      @dataset1.estimates.each do |estimate|
        @estimates1[estimate.species_id] = {} if !@estimates1.key?(estimate.species_id)
        @estimates1[estimate.species_id][estimate.event_id] = estimate.value
      end
      @dataset2 = Dataset.find(params[:compare][:dataset2_id])
      @dataset2.estimates.each do |estimate|
        @estimates2[estimate.species_id] = {} if !@estimates2.key?(estimate.species_id)
        @estimates2[estimate.species_id][estimate.event_id] = estimate.value
      end
    end
  end

  def create
    @dataset = Dataset.new(allowed_params)
    @dataset.user_id = current_user.id
    if @dataset.save
      flash[:success] = 'Your datasets was successfully created'
      redirect_to admin_datasets_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end

  def edit
    @dataset = Dataset.find(params[:id])
  end

  def activate
    @dataset = Dataset.find(params[:id])
    @dataset.activate
    flash[:notice] = "Dataset #{@dataset.id} has been activated"
    redirect_to admin_datasets_path
  end

  def update
    @dataset = Dataset.find(params[:id])
    if @dataset.update_attributes(allowed_params)
      flash[:notice] = "This dataset has been successfully updated"
      redirect_to admin_datasets_path
    else
      flash[:warning] = "There was a problem with your input"
      render "edit"
    end
  end

  def delete
    @dataset = Dataset.find(params[:id])
    params[:strategy] = 'delete'
  end
  
  def destroy
    @dataset = Dataset.find(params[:id])
    @dataset.destroy
    redirect_to admin_datasets_path
  end
  
  private 
  
    def allowed_params
      params.require(:dataset).permit([:model_id,:description])
    end

end