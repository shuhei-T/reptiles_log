class ChangeAddNotnullOnLogs < ActiveRecord::Migration[6.1]
  def change
    change_column_null :logs, :reptile_id, false
  end
end
