require_relative 'parser'
require_relative 'parsed_element'

module GoVerbal
  class IndexMapper
    attr_accessor :parser, :scraper, :ordered_index_types
    attr_writer :years, :months

    def initialize(scraper, ordered_index_types)
      @ordered_index_types = load_types(ordered_index_types)
      @scraper = scraper
      @parser = Parser.new
    end

    def load_years
      menu_links = scraper.collect_links(url: ROOT_URL, link_type: :year)

      index_years = menu_links.map do |y|
        map_element(y, :year)
      end

      index_years.sort_by {|element| element.value}
    end

    def child_elements(item)
      type = item.child_type
      url = item.url
      child_links = scraper.collect_links(url: url, link_type: type)

      child_links.each do |child_link|
        yield map_element(child_link, type)
      end
    end

    def map_element(element, type)
      child_type = ordered_index_types.fetch(type)
      text_node = get_text_node(element, type)
      text = parser.clean_text(text_node)
      url = parser.extract_url(element)

      parsed_element = ParsedElement.new(text, url)

      parsed_element.type = type
      parsed_element.child_type = child_type

      parsed_element
    end

    def get_text_node(element, type)
      if type == :section
        element.parent.children[4]
      else
        element
      end
    end

    def load_types(index_types)
      types_hash = {}

      index_types.each_index do |i|
        key = index_types[i]
        value = index_types[i+1]
        types_hash[key] = value
      end

      types_hash
    end
  end
end
