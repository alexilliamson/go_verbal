module GoVerbal
  class IndexMapper
    attr_accessor :gpo_site

    def initialize(site = nil)
      @gpo_site = site
    end

    def years
      year_list = year_elements(gpo_site)

      year_list.map{ |element| parse(element)}.sort
    end

    def year_elements(gpo_site)
      gpo_site.menu_links
    end

    def parse(element)
      element_text = element.text
      text = element_text.to_s
      text.strip
    end
  end
end
