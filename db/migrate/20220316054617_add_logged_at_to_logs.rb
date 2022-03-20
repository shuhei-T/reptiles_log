class AddLoggedAtToLogs < ActiveRecord::Migration[6.1]
  def change
    add_column :logs, :logged_at, :datetime
  end
end
