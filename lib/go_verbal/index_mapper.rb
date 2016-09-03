require_relative 'parser'
require_relative 'scraper'

module GoVerbal
  class IndexMapper
    ParsedElement = Struct.new(:value, :url)

    attr_accessor :parser, :scraper
    attr_writer :years, :months

    def initialize(scraper)
      @parser = Parser.new
      @scraper = scraper
    end

    def css_classes
      scraper.css_class_names
    end

    def years
      @years ||= load_years {}
      @years.each
    end

    def months
      @months ||= to_enum(:load_months)
    end

    def dates
      @dates ||= to_enum(:load_dates)
    end

    def load_years
      menu_links = scraper.collect_year_links

      index_years = menu_links.map{ |y| parse_element(y)}
      index_years.sort_by {|element| element.value}
    end

    def load_months
      scraper.find_months(self) do |month|
        yield parse_element(month)
      end
    end

    def load_dates
      scraper.find_dates(self) do |month|
        yield parse_element(month)
      end
    end

    def parse_element(element)
      text = parser.clean_text(element)
      url = parser.extract_url(element)

      ParsedElement.new(text, url)
    end
  end
end
