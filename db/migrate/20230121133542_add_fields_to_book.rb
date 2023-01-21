class AddFieldsToBook < ActiveRecord::Migration[7.0]
  def change
    change_table :books, bulk: true do |t|
      t.string :language
      t.string :edition_language
      t.integer :format
      t.integer :edition_number
      t.string :edition_description
      t.string :edition_title
      t.string :edition_subtitle
      t.string :image_url
      t.string :publisher_url
      t.string :asin
      t.string :goodreads_id
      t.boolean :want_to_read, null: false, default: true
    end
  end
end
