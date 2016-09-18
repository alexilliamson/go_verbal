require_relative 'parser'
require_relative 'scraper'

module GoVerbal
  class ParsedElement
    attr_accessor :value, :url, :type, :child_type

    def initialize(value, url)
      @value = value
      @url = url
    end

    def child_type=(child_type)
      @child_type = child_type
    end
  end
end
