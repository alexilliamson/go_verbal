require_relative 'browser'

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

    def menu_links(css_class)
      current_page.menu(css_class) || []
    end

    def browser
      @browser ||= Browser
    end

    def go_to(url)
      page = internet.give_me(url)
      set_current_page(page)
    end

    def internet
      @internet ||= Internet.new
    end
    private

    def set_current_page(page)
      page = HTMLMenu.new(page)
      @current_page = page
    end
  end
end
