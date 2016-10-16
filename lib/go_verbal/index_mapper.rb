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
      index_years.sort_by { |element| element.value }
    end

    def root_menu_item
      OpenStruct.new(url: ROOT_URL, child_type: :year)
    end

    def index_subsections(item)
      child_links = submenu_links(item)
      type = item.child_type

      index_location = get_index_location(item)

      child_links.map do |child_link|

        element = map_element(child_link, type)

        element.index_location = index_location

        element
      end
    end

    def submenu_links(item)
      child_type = item.child_type
      url = item.url

      child_links = scraper.collect_links(url: url, link_type: child_type).to_a
      if child_type == :text_page
        # child_links = child_links.delete_if {|l| l.attributes['href'] =~ /.pdf/}
        child_links = child_links.keep_if {|l| l.attributes['href'].to_s =~ /.htm/}
        raise "WTF #{item.url}" if child_links.empty?
      end

      child_links
    end

    def map_element(element, type)
      url = map_url(element, type)
      text = map_text(element, type)

      if type == :text_page
        HTMLTextPage.new(
          value: text,
          url: url,
          scraper: scraper
          )
      else
        child_type = ordered_index_types.fetch(type)
        ParsedElement.new(
          value: text,
          url: url,
          type: type,
          child_type: child_type
          )
      end
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
      elsif type == :text_page
        element.parent.parent.previous_element.children[1]
      else
        element
      end
    end

    def get_index_location(item)
      new_attr = {}
      new_attr[item.type] = item.value
      item.child_type == :year ? new_attr : item.index_location.merge(new_attr)
    end
  end
end
