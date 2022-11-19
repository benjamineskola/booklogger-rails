require "rails_helper"

RSpec.describe LogEntry, type: :model do
  it "is possible to mark a book as started" do
    book = create(:book)
    book.start_reading

    expect(book.log_entries).not_to be_empty
  end

  it "can't start reading a book that's already in progress" do
    book = create(:book)
    book.start_reading

    expect(book.start_reading).to be_falsy
  end

  it "is possible to mark a book as finished" do
    book = create(:book)
    book.start_reading
    book.finish_reading

    expect(book.log_entries).not_to be_empty
  end

  it "can't finish reading a book that's not in progress" do
    book = create(:book)

    expect(book.finish_reading).to be_falsy
  end
end
