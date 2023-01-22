class Author < ApplicationRecord
  has_many :first_authored_books,
    class_name: "Book",
    inverse_of: "first_author",
    foreign_key: "first_author_id",
    dependent: :destroy

  enum gender: {
    unknown: 0,
    male: 1,
    female: 2,
    organization: 3,
    nonbinary: 4
  }

  def name
    forename = (preferred_forenames.presence || forenames).presence
    if surname_first
      [surname, forename].join(" ")
    else
      [forename, surname].join(" ")
    end
  end

  def initials
    return "" if forenames.blank?

    forenames.split(/[. ]+/).pluck(0).join(".") + "."
  end

  def books
    first_authored_books
  end
end
