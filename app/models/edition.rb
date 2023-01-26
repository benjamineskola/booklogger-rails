class Edition < Book
  belongs_to :primary_edition

  delegate :first_author, :first_author_role, :first_published, :want_to_read, to: :primary_edition
  delegate :title, :subtitle, :language, to: :primary_edition, prefix: :original

  def title
    edition_title || primary_edition.title
  end

  def title=(new_title)
    @edition_title = new_title
  end

  def subtitle
    edition_subtitle || primary_edition.subtitle
  end

  def subtitle=(new_subtitle)
    @edition_subtitle = new_subtitle
  end

  def language
    edition_language || primary_edition.language
  end

  def language=(new_language)
    @edition_language = new_language
  end
end
