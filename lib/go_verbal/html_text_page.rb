require_relative 'parsed_element'

module GoVerbal
  class HTMLTextPage < ParsedElement
    attr_accessor :scraper
    def initialize(value:, url:, type:, child_type: nil, scraper: nil)
      @value = value
      @url = url
      @type = type
      @child_type = child_type
      @scraper = scraper
    end

    def title
      @value
    end

    def content
      @content ||= get_content
    end

    def get_content
      begin
        scraper.scrape_content(url)
      rescue
        raise "Can't get content for URL: #{url} VALUE: #{value}"
      end
    end
  end
end
