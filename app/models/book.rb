class Book < ApplicationRecord
  belongs_to :first_author, class_name: "Author"
  belongs_to :owner, class_name: "User", optional: true, inverse_of: "books"
  has_many :log_entries, dependent: :destroy
  has_many :editions, foreign_key: "primary_edition_id", inverse_of: "primary_edition", dependent: :destroy
  has_many :authorships, dependent: :destroy
  has_many :additional_authors, through: :authorships, source: :author
  taggable_array :tags

  enum format: {
    unknown: 0,
    paperback: 1,
    hardback: 2,
    ebook: 3,
    web: 4
  }

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
