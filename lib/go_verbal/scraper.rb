module GoVerbal
  class Scraper
    attr_accessor :browser, :css_class_names, :mapping

    def initialize(browser:, mapping: )
      @browser = browser
      @mapping = mapping
      @css_class_names = mapping.css_classes
    end

    def collect_links(url:, link_type:)
      browser.go_to(url)

      query = mapping.get_css_query(link_type)

      begin
        links = browser.xpath_query(query)
      rescue
        raise "Xpath query #{query} invalid at url #{url}"
      end
    end


    def scrape_content(url)
      browser.go_to(url)
      browser.current_page

      query = "body"
      results = browser.xpath_query(query)
        .first
        .to_s
    end
  end
end
