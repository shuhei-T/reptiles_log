class AddReptileCategoryToReptiles < ActiveRecord::Migration[6.1]
  def change
    add_column :reptiles, :reptile_category, :string
  end
end
