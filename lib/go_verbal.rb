require 'go_verbal/gpo_site_browser'
require 'go_verbal/index_mapper'

module GoVerbal
  def self.build_index(gpo_site = GPOSiteBrowser.new)
    IndexMapper.new(gpo_site)
  end
end
