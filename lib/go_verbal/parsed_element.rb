require_relative 'parser'
require_relative 'scraper'

module GoVerbal
  class ParsedElement
    attr_accessor :value, :url, :type, :child_type

    def initialize(value:, url:, type:, child_type: nil)
      @value = value
      @url = url
      @type = type
      @child_type = child_type
    end

    def child_type=(child_type)
      @child_type = child_type
    end
  end
end
