class AddTwiterHandleToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :twitter_handle, :string
    Searches.all.each do |searches|
      searches.update_attributes!(:twitter_handle => '')
    end
  end
end
