class RenameParentEdition < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :books, column: :parent_edition_id, to_table: :books
    rename_column(:books, :parent_edition_id, :primary_edition_id)
    add_foreign_key :books, :books, column: :primary_edition_id
  end
end
