class AddActiveFlagToDatasets < ActiveRecord::Migration
  def change
    add_column :datasets, :is_active, :boolean, :null => false, :default => false
    model = Model.create
    Dataset.skip_callback("create",:after,:queue_job)
    dataset = Dataset.create(:model_id => model.id, :user_id => 13, :status => 'processed', :is_active => true)
    Estimate.update_all(:dataset_id => dataset.id)
  end
end
