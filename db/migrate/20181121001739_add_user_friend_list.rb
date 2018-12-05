class AddUserFriendList < ActiveRecord::Migration
  def change
    add_column :users, :friends_list, :string, array: true, default: [] #generates an array. Works for PostgreSQL
  end
end
