class AddViewCount < ActiveRecord::Migration
  def change
    add_column :searches, :view_count, :integer
  end
end
