class Book < ApplicationRecord
  belongs_to :first_author, class_name: "Author", foreign_key: "first_author_id"
end
