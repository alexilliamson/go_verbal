require_relative 'crawler'

module GoVerbal
  class IndexMapper
    attr_accessor :gpo_site

    IndexItem = Struct.new(:value)

    def initialize(site = nil)
      @gpo_site = site
    end

    def years
      year_list = year_elements(gpo_site)

      parsed_year_list = parse_year_list(year_list)

      Enumerator.new do |y|
        parsed_year_list.each do |year|
          y << year
        end
      end
    end

    def parse_year_list(year_list)
      list = year_list.map{ |element| parse(element)}
      sort_list(list)
    end

    def sort_list(list)
      list.sort_by {|item| item.value}
    end

    def year_elements(gpo_site)
      root_page = crawler.go_to_root
      root_page.menu_links
    end

    def parse(element)
      element_text = element.text
      text = element_text.to_s

      IndexItem.new(text.strip)
    end

    def crawler
      @crawler ||= Crawler.new(gpo_site)
    end
  end
end
