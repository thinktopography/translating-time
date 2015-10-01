class Admin::TaxonomiesController < Admin::ApplicationController

  def index
    @taxonomies = Taxonomy.roots
  end

  def new
    @taxonomy = Taxonomy.new
  end

  def create
    @taxonomy = Taxonomy.new(allowed_params)
    if @taxonomy.save
      flash[:success] = 'The taxonomy was successfully created'
      redirect_to new_admin_taxonomy_path if params[:commit] == 'Save and Continue'
      redirect_to admin_taxonomies_path    if params[:commit] == 'Save and Finish'
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end

  def edit
    @taxonomy = Taxonomy.find(params[:id])
  end

  def update
    @taxonomy = Taxonomy.find(params[:id])
    if @taxonomy.update_attributes(allowed_params)
      flash[:success] = 'The taxonomy was successfully updated'
      redirect_to admin_taxonomies_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end
  
  private 
  
    def allowed_params
      params.require(:taxonomy).permit([:parent_id, :name])
    end  
  
end