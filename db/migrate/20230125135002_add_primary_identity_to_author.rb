class AddPrimaryIdentityToAuthor < ActiveRecord::Migration[7.0]
  def change
    add_reference :authors, :primary_identity, null: true, foreign_key: {to_table: :authors}
  end
end
