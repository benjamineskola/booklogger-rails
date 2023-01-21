class AddParentEditionToBook < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :parent_edition, null: true, foreign_key: {to_table: :books}
    change_column_null :books, :first_author_id, true

    # because we can't make first-author not null directly, we have to ensure it's only null if parent_edition is set
    # we also want to ensure that it _must_ be null if parent_edition is set (and vice versa)
    add_check_constraint :books, "parent_edition_id is NULL or first_author_id is NULL", name: "only_parent_or_author"
    add_check_constraint :books, "not (parent_edition_id is NULL and first_author_id is NULL)",
      name: "either_parent_or_author"
  end
end
