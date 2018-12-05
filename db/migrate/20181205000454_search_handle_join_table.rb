class SearchHandleJoinTable < ActiveRecord::Migration
  def change
    create_table :searches_twitterhandles do |t|
      t.references 'search'
      t.references 'twitterhandle'
      t.timestamps
    end
  end
end
