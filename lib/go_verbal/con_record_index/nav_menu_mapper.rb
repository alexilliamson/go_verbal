require_relative 'nav_menu'

module GoVerbal
  module NavMenuMapper
    def self.root(root_page)
      NavMenu.new
    end
  end
end
