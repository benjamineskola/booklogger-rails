class AddTagsToBook < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :tags, :string, array: true, default: []
    add_index :books, :tags, using: "gin"
  end
end
