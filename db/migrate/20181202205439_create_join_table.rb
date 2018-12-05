class CreateJoinTable < ActiveRecord::Migration
  def change
    create_table :searches_users do |t|
      t.references 'search'
      t.references 'user'
    end

  end
end
