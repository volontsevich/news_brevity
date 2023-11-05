class AddFieldsToSummaries < ActiveRecord::Migration[7.0]
  def change
    add_column :summaries, :channel_name, :string
    add_column :summaries, :min_post_length, :integer
    add_column :summaries, :start_utc_time, :datetime
    add_column :summaries, :next_utc_time, :datetime
    add_column :summaries, :delay, :integer
    add_column :summaries, :exception_dictionary, :string
    add_column :summaries, :length, :integer
    add_column :summaries, :topics_to_exclude, :text
  end
end
