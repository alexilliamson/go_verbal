require_relative 'parsed_element'
require_relative 'html_text_page'
require_relative 'gpo_site_browser'
require_relative 'scrape_mapping'
require_relative 'scraper'


module GoVerbal
  class IndexMapper

    ONLCLICK_MATCHER = /(goWithVars\(\')(?<link_a>\/fdsys.*\?collectionCode.*)\'\,/
    PAGE_DOMAIN = "https://www.gpo.gov"

    attr_accessor  :scraper, :ordered_index_types

    def initialize
      scr_mapping = ScrapeMapping.new
      @ordered_index_types = scr_mapping.ordered_index_types
      @scraper = Scraper.new
    end

    def root_menu_item
      ParsedElement.new(type: :root, child_type: :year, url: ROOT_URL, value: nil)
    end

    def map_subsections(item)
      type = item.child_type
      url = item.url
      parent_index_location = item.index_location || {}

      links = get_links(type: type, url: url)

      links.map do |link|
         map_element(link, type, parent_index_location)
      end
    end

    def get_links(type: , url: )
      links = scraper.collect_links(url: url, link_type: type).to_a

      if type == :text_page
        links = links.keep_if {|l| l.attributes['href'].to_s =~ /.htm/}
        raise "WTF #{item.url}" if links.empty?
      end

      links
    end

    def map_element(element, type, parent_index_location)
      url = map_url(element, type).to_s
      text = map_text(element, type)
      index_location = parent_index_location.merge( type => text)
      if type == :text_page
        HTMLTextPage.new(
          value: text,
          url: url,
          scraper: scraper,
          index_location: index_location
          )
      else
        child_type = ordered_index_types.fetch(type)
        ParsedElement.new(
          value: text,
          url: url,
          type: type,
          child_type: child_type,
          index_location: index_location
          )
      end
    end

    def map_url(element, type)
      if type == :text_page
        element.attributes['href'].to_s
      else
        url_source_attribute = "onclick"
        url_source = element.attributes[url_source_attribute]

        url = parse_url_source(url_source)
      end
    end

    def map_text(element, type)
      text_bearing_node = get_text_bearing_node(element, type)

      clean_text(text_bearing_node)
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

    def clean_text(element)
      element_text = element.text
      text = element_text.to_s
      text.strip
    end

    def parse_url_source(onclick)
      match = ONLCLICK_MATCHER.match(onclick) || {  }

      url = match['link_a'].to_s

      raise no_match_error(onclick) if url.empty?

      PAGE_DOMAIN + url
    end

    def no_match_error(thing)
      "NO MATCHING ONCLICK PATTERN; ELEMENT#{ thing }"
    end
  end
end
