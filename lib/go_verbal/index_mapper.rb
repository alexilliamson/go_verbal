require_relative 'parser'

module GoVerbal
  class IndexMapper
    ParsedElement = Struct.new(:value, :url)

    attr_accessor :gpo_site, :parser
    attr_writer :years

    def initialize(site = nil)
      @parser = Parser.new
      @gpo_site = site
    end

    def years
      @years ||= load_menu_years
    end

    def load_menu_years
      gpo_site.go_to_root
      year_css_class = "level1 browse-level"

      year_links = gpo_site.menu_links(year_css_class)
      index_years = map_scraped_links(year_links)
      index_years = index_years.sort_by {|item| item.value}

      index_years.each
    end

    def months
      @months ||= to_enum(:load_months)
    end

    def load_months
      month_css_class = "level2 browse-level"
      month_colllection = []
      years.each do |year|
        gpo_site.go_to(year.url)
        month_links = gpo_site.menu_links(month_css_class)
        map_scraped_months(month_links) do |month|
          yield month
        end
      end

      month_colllection
    end

    # def map_index_months(year)
    #   # year_css_class = "level1 browse-level"

    #   month_links = gpo_site.menu_links(month_css_class) do |month_link|
    #     yield map_scraped_link(month_link)
    #   end
    # end

    def map_scraped_months(months)
      months.each do |element|
        text = parser.clean_text(element)
        url = parser.extract_url(element)

        yield ParsedElement.new(text, url)
      end
    end

    def map_scraped_links(menu_links)
      menu_links.map do  |element|
        text = parser.clean_text(element)
        url = parser.extract_url(element)

        yield menu_links if block_given?
        ParsedElement.new(text, url)
      end
    end
  end
end
