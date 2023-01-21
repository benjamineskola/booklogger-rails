require "rails_helper"

RSpec.describe Edition, type: :edition do
  let(:parent_edition) { create(:primary_edition) }
  let(:edition) { create(:edition, parent_edition: parent_edition) }

  it "has its parent edition's title" do
    expect(edition.title).to be(parent_edition.title)
  end

  it "has its parent edition's first author" do
    expect(edition.first_author).to be(parent_edition.first_author)
  end

  it "has its own isbn" do
    expect(edition.isbn).not_to eq(parent_edition.isbn)
  end
end
