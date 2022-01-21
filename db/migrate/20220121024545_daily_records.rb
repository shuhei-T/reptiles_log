class DailyRecords < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :daily_records, :reptiles
    remove_index :logs, :daily_record_id
    remove_reference :logs, :daily_record
    
    drop_table :daily_records
  end
end
