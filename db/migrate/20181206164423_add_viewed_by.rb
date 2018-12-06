class AddViewedBy < ActiveRecord::Migration
  def change
    add_column :searches, :viewed_by, :string, array: true, default: [] #generates an array. Works for PostgreSQL
  end
end
