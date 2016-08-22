require 'go_verbal/gpo_site'
require 'go_verbal/index_mapper'
module GoVerbal
  def self.build_index(gpo_site=GPOSite.new)
    IndexMapper.new(gpo_site)
  end
end
