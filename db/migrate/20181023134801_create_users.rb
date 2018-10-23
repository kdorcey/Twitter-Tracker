class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string 'user_name'
      t.string 'email'
      t.string 'password'
      t.string 'country'

      t.string 'session_token'
      t.string 'search_inputs'
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
end
