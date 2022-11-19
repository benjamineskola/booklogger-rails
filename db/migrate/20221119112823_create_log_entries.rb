class CreateLogEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :log_entries do |t|
      t.references :book, null: false, foreign_key: true
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.datetime :progress_date
      t.integer :progress_page
      t.float :progress_percentage
      t.boolean :exclude_from_stats
      t.boolean :abandoned
      t.integer :start_precision
      t.integer :end_precision

      t.timestamps
    end
  end
end
