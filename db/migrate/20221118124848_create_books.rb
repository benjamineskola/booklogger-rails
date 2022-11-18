class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :subtitle
      t.references :first_author, null: false, foreign_key: {to_table: :authors}
      t.string :first_author_role
      t.integer :first_published, limit: 2
      t.integer :edition_published, limit: 2
      t.string :publisher
      t.integer :page_count, limit: 2
      t.string :isbn

      t.timestamps
    end
  end
end
