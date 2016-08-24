require_relative 'parser'

module GoVerbal
  class IndexMapper
    ParsedElement = Struct.new(:value, :url)

    attr_accessor :gpo_site, :parser, :month_css_class

    def initialize(site = nil)
      @parser = Parser.new
      @gpo_site = site
    end

    def years
      gpo_site.go_to_root
      year_css_class = "level1 browse-level"

      year_links = gpo_site.menu_links(year_css_class)
      index_years = map_scraped_links(year_links)
      index_years = index_years.sort_by {|item| item.value}

      index_years.each
    end

    # def months
    #   Enumerator.new do |y|
    #     years.each do |year|
    #       scrape_months(year) do |month|
    #         y << month
    #       end
    #     end
    #   end
    # end

    def map_index_months(url)
      gpo_site.go_to(url)
      gpo_site.menu_links(month_css_class)
    end

    def map_scraped_links(menu_links)
      menu_links.map do  |element|
        text = parser.clean_text(element)
        url = parser.extract_url(element)

        ParsedElement.new(text, url)
      end
    end
  end
end
