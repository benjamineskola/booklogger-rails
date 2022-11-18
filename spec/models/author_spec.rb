require "rails_helper"

RSpec.describe Author, type: :model do
  # initials
  it "returns the initials of an author" do
    author = create(:author, forenames: "John Ronald Reuel", surname: "Tolkien")

    expect(author.initials).to eq("J.R.R.")
  end

  it "normalises the initials of an author" do
    ["J R R", "J. R. R."].each do |forename|
      author = create(:author, forenames: forename, surname: "Tolkien")

      expect(author.initials).to eq("J.R.R.")
    end
  end

  # full name
  it "combines forenames and surname to display full name" do
    author = create(:author, forenames: "John Ronald Reuel", surname: "Tolkien")

    expect(author.name).to eq("John Ronald Reuel Tolkien")
  end

  context "there is a preferred forename for the author" do
    it "combines forenames and surname to display full name" do
      author = create(:author, forenames: "John Ronald Reuel", preferred_forenames: "J.R.R.", surname: "Tolkien")

      expect(author.name).to eq("J.R.R. Tolkien")
    end
  end
end
