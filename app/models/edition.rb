class Edition < Book
  belongs_to :parent_edition, class_name: "Book"

  delegate :first_author, :first_author_role, :first_published, :want_to_read, to: :parent_edition
  delegate :title, :subtitle, :language, to: :parent_edition, prefix: :original

  def title
    edition_title || parent_edition.title
  end

  def title=(new_title)
    @edition_title = new_title
  end

  def subtitle
    edition_subtitle || parent_edition.subtitle
  end

  def subtitle=(new_subtitle)
    @edition_subtitle = new_subtitle
  end

  def language
    edition_language || parent_edition.language
  end

  def language=(new_language)
    @edition_language = new_language
  end
end
