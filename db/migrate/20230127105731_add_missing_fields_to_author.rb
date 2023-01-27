class AddMissingFieldsToAuthor < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :primary_language, :string
  end
end
