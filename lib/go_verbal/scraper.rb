module GoVerbal
  class Scraper
    attr_accessor :site, :css_class_names

    def initialize(browser:, css_class_names: {})
      @site = browser
      @css_class_names = css_class_names
    end

    def collect_links(url:, link_type:)
      site.go_to(url)
      css_class = css_class_names.fetch(link_type)

      links = site.menu_links(css_class)
    end
  end
end
