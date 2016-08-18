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
      elements = gpo_site.browse_level_links
      index_years = elements.map{ |element| parse(element)}

      @nav_menu = NavMenu.new(years: index_years)
    end

    def parse(element)
      {text: element.text}
    end

    def extract_year_nodes(nav_menu)
      # [nil]
    end
  end
end
