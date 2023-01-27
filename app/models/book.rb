class Book < ApplicationRecord
  belongs_to :first_author, class_name: "Author"
  belongs_to :owner, class_name: "User", optional: true, inverse_of: "books"
  has_many :log_entries, dependent: :destroy
  has_many :editions, foreign_key: "primary_edition_id", inverse_of: "primary_edition", dependent: :destroy
  has_many :authorships, dependent: :destroy
  has_many :additional_authors, through: :authorships, source: :author

  belongs_to :parent_edition, class_name: "Book", inverse_of: "subeditions", optional: true, dependent: :destroy
  has_many :subeditions, class_name: "Book", inverse_of: "parent_edition", foreign_key: "parent_edition_id",
    dependent: :destroy

  taggable_array :tags

  enum format: {
    unknown: 0,
    paperback: 1,
    hardback: 2,
    ebook: 3,
    web: 4
  }

  default_scope {
    joins(:first_author).order("authors.surname, authors.forenames, series, series_order, title")
  }

  scope :want_to_read, -> { where(want_to_read: true) }
  scope :currently_reading, -> { where.associated(:log_entries).where(log_entries: {end_date: nil}) }
  scope :read, -> { where.associated(:log_entries).where.not(log_entries: {end_date: nil}) }
  scope :owned, -> { where(owner_id: 1) }
  scope :shared, -> { where(owner_id: 2) }
  scope :fiction, -> { with_any_tags("fiction") }
  scope :nonfiction, -> { with_any_tags("non-fiction") }

  def rating
    super.to_i / 2.0
  end

  def rating=(new_rating)
    super(new_rating * 2)
  end

  def currently_reading?
    log_entries.present? && log_entries.last.currently_reading?
  end

  def start_reading
    if currently_reading?
      nil
    else
      log_entry = LogEntry.new
      log_entries << log_entry
      log_entry
    end
  end

  def finish_reading
    if currently_reading?
      log_entries.last.finish_reading
    end
  end
end
