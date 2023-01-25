class AddSeriesToBook < ActiveRecord::Migration[7.0]
  def change
    change_table :books, bulk: true do |t|
      t.string :series
      t.float :series_order
    end
  end
end
