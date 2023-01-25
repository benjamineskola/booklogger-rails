require "faraday"
require "json"

$not_implemented = [] # rubocop:disable Style/GlobalVars

def create_author(author_data)
  author = Author.find_or_create_by(id: author_data[:id]) do |a|
    author_data.each_pair do |k, v|
      if k == :primary_identity
        k = :primary_identity_id
      end

      a.send("#{k}=", v)
    rescue NoMethodError
      puts "Not implemented yet? `#{k}`"
    end
  end
  author.save!
end

def create_book(book_data)
  book_class = if book_data[:primary_edition].present?
    book_data.delete :first_author
    book_data.delete :first_author_role

    book_data[:parent_edition_id] = book_data.delete :parent_edition if book_data[:parent_edition].present?
    book_data[:parent_edition_id] = book_data.delete :primary_edition if book_data[:primary_edition].present?
    Edition
  else
    PrimaryEdition
  end
  book = book_class.find_or_create_by(id: book_data[:id]) do |new_book|
    book_data.each_pair do |k, v|
      next if k == :log_entries

      k = :format if k == :edition_format  # changed name
      if k == :first_author
        v = Author.find(v)
      end
      new_book.send("#{k}=", v)
    rescue NoMethodError
      $not_implemented << k unless $not_implemented.include? k # rubocop:disable Style/GlobalVars
    end
  end
  book.save!

  if book_data[:log_entries].present?
    book_data[:log_entries] = book_data[:log_entries].map do |entry_data|
      entry_data[:start_date] ||= entry_data[:end_date]
      entry = LogEntry.find_or_create_by(book: book, start_date: entry_data[:start_date]) do |le|
        le.start_date = entry_data[:start_date]
        le.end_date = entry_data[:end_date]
      end
      entry.save!
    end
  end
end

task import: :environment do
  deferred_authors = []
  deferred_books = []

  puts "importing authors"
  url = "https://booklogger.eskola.uk/export/authors/"
  (1..).each do |page|
    response = Faraday.get(url, {page: page}, {"Accept" => "application/json"})
    result = JSON.parse(response.body, symbolize_names: true)
    puts "#{result[:authors].first[:surname]}…#{result[:authors].last[:surname]}"
    result[:authors].each do |author_data|
      if author_data[:primary_identity].present?
        deferred_authors << author_data
      else
        create_author(author_data)
      end
    end

    if page == result[:total_pages]
      break
    end
  end
  deferred_authors.each do |author_data|
    create_author(author_data)
  end

  puts "importing books"
  url = "https://booklogger.eskola.uk/export/books/"
  (1..).each do |page|
    response = Faraday.get(url, {page: page}, {"Accept" => "application/json"})
    result = JSON.parse(response.body, symbolize_names: true)
    puts (result[:books].first[:edition_title] || result[:books].first[:title]).to_s + "…" \
    + (result[:books].last[:edition_title] || result[:books].last[:title]).to_s

    result[:books].each do |book_data|
      if book_data[:primary_edition].present?
        deferred_books << book_data
      else
        create_book(book_data)
      end
    end

    if page == result[:total_pages]
      break
    end
  end
  deferred_books.each do |book_data|
    create_book(book_data)
  end

  puts "not implemented: #{$not_implemented}" # rubocop:disable Style/GlobalVars
end
