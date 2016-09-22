require_relative 'parser'
require_relative 'parsed_element'

module GoVerbal
  class IndexMapper
    attr_accessor :parser, :scraper, :ordered_index_types
    attr_writer :years, :months

    def initialize(scraper:, mapping: )
      @ordered_index_types = mapping.ordered_index_types
      @scraper = scraper
      @parser = Parser.new
    end

    def load_years
      index_years = index_subsections(root_menu_item)
      index_years.sort_by {|element| element.value}
    end

    def root_menu_item
      OpenStruct.new(url: ROOT_URL, child_type: :year)
    end

    def index_subsections(item)
      child_links = submenu_links(item)
      type = item.child_type

      child_links.map { |child_link| map_element(child_link, type) }
    end

    def submenu_links(item)
      child_type = item.child_type
      url = item.url

      child_links = scraper.collect_links(url: url, link_type: child_type)
    end

    def map_element(element, type)
      child_type = ordered_index_types.fetch(type)
      text = map_text(element, type)
      url = map_url(element, type)
      # parsed_element.type = type

      ParsedElement.new(
        value: text,
        url: url,
        type: type,
        child_type: child_type
        )
    end

    def map_url(element, type)
      if type == :text_page
        element.attributes['href']
      else
        parser.extract_url(element)
      end
    end

    def map_text(element, type)
      text_bearing_node = get_text_bearing_node(element, type)

      parser.clean_text(text_bearing_node)
    end

    def get_text_bearing_node(element, type)
      if type == :section
        element.parent.children[4]
      else
        element
      end
    end
  end
end
