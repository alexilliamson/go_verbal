require_relative 'parser'
require_relative 'scraper'

module GoVerbal
  class IndexMapper
    class ParsedElement
      attr_accessor :value, :url, :type, :child_type

      def initialize(value, url)
        @value = value
        @url = url
      end

      def child_type=(child_type)
        @child_type = child_type
      end
    end

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
      @years ||= load_years
      @years.each
    end

    def months
      collection = years

      enumerate_children(collection)
    end

    def dates
      collection = months

      enumerate_children(collection)
    end

    def sections
      enumerate_children(dates)
    end

    def enumerate_children(collection)
      Enumerator.new do |y|
        collection.each do |item|
          type = item.type

          scraper.collect_child_links(item) do |parent_link|
            y << map_element(parent_link, type: type)
          end
        end
      end
    end

    def map_element(element, child_type)
      parsed_element = parse_element(element)
      parsed_element.child_type = :date

      parsed_element
    end

    def load_years
      menu_links = scraper.collect_year_links

      index_years = menu_links.map do |y|
        parsed_element = parse_element(y)
        parsed_element.child_type = :month
        parsed_element
      end

      index_years.sort_by {|element| element.value}
    end

    def parse_element(element)
      text = parser.clean_text(element)
      url = parser.extract_url(element)

      ParsedElement.new(text, url)
    end
  end
end
