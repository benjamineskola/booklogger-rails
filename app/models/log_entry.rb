class LogEntry < ApplicationRecord
  belongs_to :book

  date_precision = {day: 0, month: 1, year: 2}
  enum :start_precision, date_precision, prefix: true
  enum :end_precision, date_precision, prefix: true

  attribute :start_date, :datetime, default: -> { DateTime.now }

  def currently_reading?
    start_date.present? && end_date.blank?
  end

  def finish_reading
    if currently_reading?
      update end_date: DateTime.now
    end
  end
end
