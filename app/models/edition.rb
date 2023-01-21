class Edition < Book
  belongs_to :parent_edition, class_name: "Book"

  delegate :title, :subtitle, :first_author, :first_author_role, :first_published, to: :parent_edition
end
