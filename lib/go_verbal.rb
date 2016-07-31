require 'go_verbal/con_record_index'
require 'go_verbal/text_page_url'

module GoVerbal
  def self.get_con_record_index
    ConRecordIndex.new
  end
end
