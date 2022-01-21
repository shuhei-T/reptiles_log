class RemoveTypeFromFeeds < ActiveRecord::Migration[6.1]
  def change
    remove_column :feeds, :type, :string
  end
end
