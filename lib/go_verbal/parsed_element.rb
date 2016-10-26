require_relative 'scraper'

module GoVerbal
  class ParsedElement
    attr_accessor :value, :url, :type, :child_type, :index_location

    def initialize(value:, url:, type:, child_type: nil, index_location: nil)
      @value = value
      @url = url
      @type = type
      @child_type = child_type
      @index_location = index_location
    end

    def child_type=(child_type)
      @child_type = child_type
    end

    def each_descendent
      first_descendents.each do |first_desc|
        yield first_desc
        first_desc.each_descendent {|sec_desc| yield sec_desc}
      end
    end

    def first_descendents
      mapper.map_subsections(self)
    end

    def mapper
      @mapper ||= IndexMapper.new
    end
  end
end
