class AddSizeToLogFeeds < ActiveRecord::Migration[6.1]
  def change
    add_column :log_feeds, :size, :integer
  end
end
