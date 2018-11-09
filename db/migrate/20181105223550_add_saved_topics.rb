class AddSavedTopics < ActiveRecord::Migration
  def change
   add_column :searches, :saved, :boolean
    Searches.all.each do |searches|
      searches.update_attributes!(:saved => false)
    end
  end
end
