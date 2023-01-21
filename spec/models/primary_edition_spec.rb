require "rails_helper"

RSpec.describe PrimaryEdition, type: :primary_edition do
  let(:book) { create(:primary_edition, language: "en") }

  it "has an #original_title" do
    expect(book.original_title).to be(book.title)
  end

  it "has an #original_subtitle" do
    expect(book.original_subtitle).to be(book.subtitle)
  end

  it "has an #original_language" do
    expect(book.original_language).to be(book.language)
  end
end
