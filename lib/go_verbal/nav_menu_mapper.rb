module GoVerbal
  class NavMenuMapper
    attr_accessor :gpo_site, :nav_menu

    NavMenu = Struct.new(:years) do
      def initialize(attributes)
        attributes.each do |k,v|
          self[k] = v
        end
      end
    end

    def initialize(site = nil)
      @gpo_site = site
    end

    def build
      div_id = lookup_div_id(:year)

      links = gpo_site.browse_level_links(id: div_id)
      index_years = links.map{ |link| parse(link)}

      @nav_menu = NavMenu.new(years: index_years)
    end

    def parse(link)
    end

    def extract_year_nodes(nav_menu)
      # [nil]
    end

    def lookup_div_id(key)
      div_ids = {year: nil}
      div_ids[key]
    end
  end
end
