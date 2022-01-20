class CreateDailyRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_records do |t|
      t.date :take_care_time, null: false, index: true
      t.references :reptile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
