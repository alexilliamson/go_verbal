require 'go_verbal/gpo_site'
require 'go_verbal/index_mapper'
module GoVerbal
  def self.get_con_record_index
    ConRecordIndex.new
  end

  def self.build_index(gpo_site)
    IndexMapper.new(gpo_site)
  end
end
