class CreateAuthorships < ActiveRecord::Migration[7.0]
  def change
    create_table :authorships do |t|
      t.references :book, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true
      t.string :role
      t.integer :order

      t.timestamps
    end
  end
end
