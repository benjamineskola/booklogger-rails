class Book < ApplicationRecord
  belongs_to :first_author, class_name: "Author"
  has_many :log_entries, dependent: :destroy

  def currently_reading?
    log_entries.present? && log_entries.last.currently_reading?
  end

  def start_reading
    if currently_reading?
      nil
    else
      log_entry = LogEntry.new
      log_entries << log_entry
      log_entry
    end
  end

  def finish_reading
    if currently_reading?
      log_entries.last.finish_reading
    end
  end
end
