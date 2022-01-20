class AddLogRefToLogfeeds < ActiveRecord::Migration[6.1]
  def change
    add_reference :log_feeds, :log, null: false, foreign_key: true
  end
end
