class FixObservations < ActiveRecord::Migration
  def up
    add_column :observations, :old_species_id, :integer
    Observation.all.each do |observation|
      observation.old_species_id = observation.species_id
      observation.save(:validate => false)
    end
    Observation.where(:old_species_id => 46).update_all(:species_id => 31)
    Observation.where(:old_species_id => 47).update_all(:species_id => 48)
    Observation.where(:old_species_id => 48).update_all(:species_id => 30)
    Observation.where(:old_species_id => 49).update_all(:species_id => 50)
    Observation.where(:old_species_id => 50).update_all(:species_id => 51)
    Observation.where(:old_species_id => 51).update_all(:species_id => 52)
    Species.delete_all(:id => 47)
    Species.delete_all(:id => 49)
    remove_column :observations, :old_species_id
  end

  def down
  end
end
