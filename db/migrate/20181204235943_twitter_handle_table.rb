class TwitterHandleTable < ActiveRecord::Migration
  def change
    create_table :twitterhandles do |t|
      t.string 'handle'
      t.timestamps

    end
  end
end
