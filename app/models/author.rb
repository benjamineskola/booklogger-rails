class Author < ApplicationRecord
  has_many :first_authored_books,
    class_name: "Book",
    inverse_of: "first_author",
    foreign_key: "first_author_id",
    dependent: :destroy

  belongs_to :primary_identity,
    class_name: "Author",
    inverse_of: "pseudonyms",
    optional: true,
    dependent: :destroy
  has_many :pseudonyms,
    class_name: "Author",
    inverse_of: "primary_identity",
    foreign_key: "primary_identity_id",
    dependent: :destroy

  has_many :authorships, dependent: :destroy
  has_many :additional_authored_books, through: :authorships, source: :book

  enum gender: {
    unknown: 0,
    male: 1,
    female: 2,
    organization: 3,
    nonbinary: 4
  }

  default_scope { order(:surname, :forenames) }

  def name
    forename = (preferred_forenames.presence || forenames).presence
    if surname_first
      [surname, forename].compact.join(" ")
    else
      [forename, surname].compact.join(" ")
    end
  end

  def name_sortable
    forename = (preferred_forenames.presence || forenames).presence
    [surname, forename].compact.join(surname_first ? " " : ", ")
  end

  def initials
    return "" if forenames.blank?

    forenames.split(/[. ]+/).pluck(0).join(".") + "."
  end

  def books
    first_authored_books
  end
end
