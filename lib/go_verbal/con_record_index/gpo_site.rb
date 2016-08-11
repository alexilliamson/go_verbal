require_relative 'nav_menu_mapper'
require_relative 'internet'

module GoVerbal
  class GPOSite
    ROOT_URL = "https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC"

    attr_accessor :nav_menu

    def go_to_root
      root_page = get_page(url: ROOT_URL)
      @nav_menu = NavMenuMapper.root(root_page)
    end

    def get_page(url: )
      uri = convert_to_uri(url)

      internets = Internet.new(uri.host, uri.port)
      internets.html
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
  end
end
