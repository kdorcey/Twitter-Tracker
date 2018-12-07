class DropHandles < ActiveRecord::Migration
  def change
    remove_column :searches, :handle
  end
end
