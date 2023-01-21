class Edition < Book
  belongs_to :parent_edition, class_name: "Book"

  delegate :title, :subtitle, :first_author, :first_author_role, :first_published, :want_to_read, to: :parent_edition
end
