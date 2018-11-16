class CreateUsers < ActiveRecord::Migration
  #def change
  def self.up
    create_table :users do |t|
      t.string 'user_name'
      t.string 'email'
      t.string 'password'
      t.string 'country'

      t.string 'session_token'
      t.string 'search_inputs'
      t.string 'current_search'
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end

    create_table :searches do |t|
      t.integer 'user_id'
      t.string 'search_term'
      t.string 'from_date'
      t.string 'to_date'
      t.string 'number_of_tweets'
      t.string 'graph_data'

      t.timestamps
    end
  end

  def self.down
    drop_table :searches
    drop_table :users
  end
  #end
end
