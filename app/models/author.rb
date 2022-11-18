class Author < ApplicationRecord
  has_many :first_authored_books, class_name: "Book", inverse_of: "first_author", foreign_key: "first_author_id"

  enum gender: {
    unknown: 0,
    male: 1,
    female: 2,
    organization: 3,
    nonbinary: 4
  }

  def name
    if surname_first
    else
      (preferred_forenames || forenames) + " " + surname
    end
  end

  def initials
    return "" if forenames.blank?

    forenames.split(/[. ]+/).map { |name| name[0] }.join(".") + "."
  end

  def books
    first_authored_books
  end
end
