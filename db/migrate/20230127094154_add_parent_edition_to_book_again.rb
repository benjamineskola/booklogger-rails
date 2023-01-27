class AddParentEditionToBookAgain < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :parent_edition, null: true, foreign_key: {to_table: :books}
  end
end
