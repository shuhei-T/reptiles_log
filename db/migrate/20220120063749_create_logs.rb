class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.text :remark
      t.integer :condition
      t.integer :shit
      t.boolean :bath, default: false, null: false
      t.boolean :handling, default: false, null: false
      t.boolean :creaning, default: false, null: false
      t.integer :sheding
      t.float :weight
      t.float :length
      t.string :image
      t.float :temperature
      t.float :humidity
      t.references :user, null: false, foreign_key: true
      t.references :daily_record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
