require "faraday"
require "json"

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

task import: :environment do
  deferred_authors = []

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
      book = PrimaryEdition.find_or_create_by(id: book_data[:id]) do |new_book|
        book_data.each_pair do |k, v|
          next if k == :log_entries

          k = :format if k == :edition_format  # changed name
          if k == :first_author
            v = Author.find(v)
          end
          new_book.send("#{k}=", v)
        rescue NoMethodError
          puts "Not implemented yet? `#{k}`"
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

    if page == result[:total_pages]
      break
    end
  end
end
