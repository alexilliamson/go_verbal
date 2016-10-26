module GoVerbal
  class Scraper
    attr_accessor :browser,  :mapping

    def initialize
      @browser = GPOSiteBrowser.new
      @mapping = ScrapeMapping.new
    end

    def collect_links(url:, link_type:)
      browser.go_to(url)

      query = mapping.get_css_query(link_type)

      begin
        query_results = browser.xpath_query(query)
        query_results.map do |result|
          result#OpenStruct.new(url: ROOT_URL, child_type: :year)
        end
        #
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
