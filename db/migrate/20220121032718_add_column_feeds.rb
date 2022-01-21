class AddColumnFeeds < ActiveRecord::Migration[6.1]
  def change
    add_column :feeds, :type, :string
  end
end
