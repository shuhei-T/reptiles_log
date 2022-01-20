class CreateLogFeeds < ActiveRecord::Migration[6.1]
  def change
    create_table :log_feeds do |t|
      t.integer :count
      t.references :feed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
