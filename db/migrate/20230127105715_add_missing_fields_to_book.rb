class AddMissingFieldsToBook < ActiveRecord::Migration[7.0]
  def change
    change_table :books, bulk: true do |t|
      t.integer :rating, limit: 1
      t.text :review
      t.boolean :private
    end
  end
end
