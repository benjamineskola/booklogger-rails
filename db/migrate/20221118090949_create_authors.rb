class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :forenames
      t.string :surname
      t.string :preferred_forenames
      t.boolean :surname_first
      t.integer :gender
      t.boolean :poc
      t.string :slug

      t.timestamps
    end
  end
end
