class CreateReptiles < ActiveRecord::Migration[6.1]
  def change
    create_table :reptiles do |t|
      t.string :name, null: false
      t.string :morph
      t.integer :sex
      t.date :birthday
      t.date :adoptaversary
      t.string :image
      t.text :comment
      t.integer :age
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
