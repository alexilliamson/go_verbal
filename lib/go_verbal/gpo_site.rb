require_relative 'nav_menu_mapper'
require_relative 'internet'

module GoVerbal
  ROOT_URL = "https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC"

  class GPOSite

    attr_accessor :nav_menu
    attr_reader :current_page

    def initialize
      yield self if block_given?
    end

    def go_to_root
      @current_page = get_page(url: ROOT_URL)
      # @nav_menu = current_page.buttons
      # NavMenuMapper.build
    end

    def get_page(url: )
      internet = Internet.new

      internet.give_me(url)
    end

    def go_to_year(year)
    end

    def go_to_month(month)
    end

    def go_to_date(date)
    end

    def convert_to_uri(url)
      URI(url)
    end

    def nav_menu_html
    end

    def extract_nav_menu(page)
    end

    def browse_level_links
      div_class = lookup_div_class(:year)
      current_page.div(:css_class => div_class)
    end

    def lookup_div_class(key)
      div_classes = {year: "level1 browse-level"}
      div_classes[key]
    end
  end
end
