class AddSavedTopics < ActiveRecord::Migration
  def change
   add_column :searches, :saved, :boolean
   add_column :searches, :country, :string
    Search.all.each do |searches|
      searches.update_attributes!(:saved => false)
      searches.update_attributes!(:country => '')
    end
  end
end
