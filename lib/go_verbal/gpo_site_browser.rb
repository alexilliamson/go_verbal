require_relative 'Internet'

module GoVerbal
  ROOT_URL = "https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC"

  class GPOSiteBrowser
    attr_accessor  :current_page_menu
    attr_writer :internet

    def initialize
      yield self if block_given?
    end

    def go_to_root
      go_to(ROOT_URL)
    end

    def menu_links(css_class)
      raise "CURRENT PAGE_MENU NOT SET" unless current_page_menu
      elements = current_page_menu.div(css_class)
      if elements.any?
        return elements
      else
        raise "NO MENU LINKS {#css_class: #{css_class}}"
      end
    end

    def go_to(url)
      page = internet.give_me(url)
      set_current_page_menu(page)
    end

    def internet
      @internet ||= Internet.new
    end

    private

    def set_current_page_menu(page)
      @current_page_menu = HTMLMenu.new(page)
    end
  end
end
