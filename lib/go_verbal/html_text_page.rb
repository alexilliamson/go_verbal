require_relative 'parsed_element'

module GoVerbal
  class HTMLTextPage < ParsedElement
    attr_accessor :scraper, :index_location
    def initialize(value:, url:, scraper: nil, index_location: nil)
      @value = value
      @url = url
      @scraper = scraper
      @index_location = index_location
    end

    def title
      @value
    end

    def content
      @content ||= get_content
    end

    def attributes
      {
        url: url,
        title: title,
        date: date,
        section: section
      }
    end

    def date
      @date ||= get_date(index_location)
    end

    def section
      @section ||= index_location[:section]
    end

    def get_date(index_location)
      day = index_location[:date]
      month = index_location[:month]
      year = index_location[:year]

      Date.parse(day + " " + year)
    end

    def get_content
        scraper.scrape_content(url)
    end

    def each_descendent
    end
  end
end
