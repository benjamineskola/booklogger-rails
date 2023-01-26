class RenameParentEdition < ActiveRecord::Migration[7.0]
  def change
    rename_column(:books, :parent_edition_id, :primary_edition_id)
  end
end
