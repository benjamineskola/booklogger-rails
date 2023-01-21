require "rails_helper"

RSpec.describe Edition, type: :edition do
  let(:parent_edition) { create(:primary_edition, language: "en") }
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

  context "when it has an overridden title" do
    let(:edition) {
      create(:edition, parent_edition: parent_edition,
        edition_title: "A new title", edition_subtitle: "Maybe a translation?")
    }

    it "has an overridden #title" do
      expect(edition.title).to eq("A new title")
    end

    it "has an overridden #subtitle" do
      expect(edition.subtitle).to eq("Maybe a translation?")
    end

    it "has an #original_title that returns the parent_edition's" do
      expect(edition.original_title).to be(edition.parent_edition.title)
    end

    it "has an #original_subtitle that returns the parent_edition's" do
      expect(edition.original_subtitle).to be(edition.parent_edition.subtitle)
    end
  end

  context "when it has an overridden language" do
    let(:edition) {
      create(:edition, parent_edition: parent_edition,
        edition_language: "fi")
    }

    it "has an overridden #language" do
      expect(edition.language).to eq("fi")
    end

    it "has an #original_language that returns the parent_edition's" do
      expect(edition.original_language).to be(edition.parent_edition.language)
    end
  end
end
