
class CreateSearches < ActiveRecord::Migration

end
=begin
  def self.up
    create_table :searches do |t|
      t.integer 'user_id'
      t.string 'search_term'
      t.string 'from_date'
      t.string 'to_date'
      t.string 'number_of_tweets'
      t.timestamps
    end
  end

  def self.down
    drop_table :searches
  end
end
=end
