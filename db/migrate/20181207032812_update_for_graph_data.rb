class UpdateForGraphData < ActiveRecord::Migration
  def change
    add_column :searches_twitterhandles, :graph_data, :string
    add_column :searches_twitterhandles, :number_of_tweets, :string

    remove_column :searches, :number_of_tweets
  end
end
