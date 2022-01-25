class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :log_feeds, :feed_id, true
    change_column_null :log_feeds, :log_id, true
  end
  
  def down
    change_column_null :log_feeds, :feed_id, false
    change_column_null :log_feeds, :log_id, false
  end
end
