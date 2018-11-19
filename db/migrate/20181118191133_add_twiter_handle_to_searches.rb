class AddTwiterHandleToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :twitter_handle, :string
  end
end
