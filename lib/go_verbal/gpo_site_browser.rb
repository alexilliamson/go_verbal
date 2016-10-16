require_relative 'Internet'

module GoVerbal
  ROOT_URL = "https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC"

  class GPOSiteBrowser
    attr_accessor  :current_page
    attr_writer :internet

    def initialize
      yield self if block_given?
    end

    def go_to_root
      go_to(ROOT_URL)
    end

    def go_to(url)
      page = internet.give_me(url)
      set_current_page(page)
    end

    def xpath_query(xpath_query)
      raise "CURRENT PAGE NOT SET" unless current_page

      elements = current_page.css(xpath_query)

      if elements.any?
        return elements
      else
        raise no_xpath_query_error(xpath_query)
      end
    end

    def no_xpath_query_error(xpath_query)
      "NO MENU LINKS { XPATH: #{ xpath_query } }"
    end


    def internet
      @internet ||= Internet.new
    end

    private

    def set_current_page(page)
      @current_page = NokogiriHTMLDocWrapper.new(page)
    end
  end
end
