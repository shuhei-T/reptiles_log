class ChangeLogsColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :logs, :image, :string
    add_column :logs, :images, :json
  end
end
