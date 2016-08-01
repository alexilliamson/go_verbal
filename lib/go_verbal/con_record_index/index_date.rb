require_relative 'nav_menu'

module GoVerbal
  class IndexDate
    attr_accessor :url

    def initialize(url:)

    end

    def sections
      @sections ||= load_sections
    end

    def load_sections
      nav_menu.sections(self)
    end


    def nav_menu
      @nav_menu ||= NavMenu.new
    end
  end
end
