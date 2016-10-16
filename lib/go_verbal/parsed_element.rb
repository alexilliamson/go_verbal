require_relative 'parser'
require_relative 'scraper'

module GoVerbal
  class ParsedElement
    attr_accessor :value, :url, :type, :child_type, :index_location

    def initialize(value:, url:, type:, child_type: nil)
      @value = value
      @url = url
      @type = type
      @child_type = child_type
    end

    def child_type=(child_type)
      @child_type = child_type
    end

    def each_month(mapper)
      mapper.index_subsections(self).each
    end
  end
end
