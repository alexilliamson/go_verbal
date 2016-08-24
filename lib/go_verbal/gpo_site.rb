require_relative 'browser'

module GoVerbal
  ROOT_URL = "https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC"

  class GPOSite
    attr_reader :current_page
    attr_accessor :menu_css_classes

    def initialize
      @menu_css_classes = ["level1 browse-level"]

      yield self if block_given?
    end

    def go_to_root
      root_page = browser.go_to(ROOT_URL)
      set_current_page(root_page)
    end

    def menu_links(css_class)
      current_page.menu(css_class)
    end

    def browser
      Browser
    end

    def go_to(item)
    end

    private

    def set_current_page(page)
      @current_page = page
    end
  end
end
