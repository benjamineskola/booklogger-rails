class AddOwnershipToBook < ActiveRecord::Migration[7.0]
  def change
    change_table :books, bulk: true do |t|
      t.references :owner, null: true, foreign_key: {to_table: :users}
      t.boolean :was_borrowed
      t.string :borrowed_from
      t.date :acquired_date
      t.date :alienated_date
    end
  end
end
