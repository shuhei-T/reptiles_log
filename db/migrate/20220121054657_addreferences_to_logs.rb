class AddreferencesToLogs < ActiveRecord::Migration[6.1]
  def change
    add_reference :logs, :reptile, foreign_key: true
  end
end
