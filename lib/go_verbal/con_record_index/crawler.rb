require_relative "index_date"

module GoVerbal
  class Crawler
    def find_index_date(date)
      month = extract_month(date)
      index_month = find_index_month(month)

      index_month.dates(date)
    end

    def extract_month(date)
      date.month
    end
  end
end
