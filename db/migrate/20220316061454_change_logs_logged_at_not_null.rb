class ChangeLogsLoggedAtNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :logs, :logged_at, false
  end
end
