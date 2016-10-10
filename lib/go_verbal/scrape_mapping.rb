module GoVerbal
  class ScrapeMapping
    def initialize(mapping)
      @mapping = mapping
    end

    def ordered_index_types
      @ordered_index_types ||= load_types(mapping.keys)
    end

    def load_types(index_types)
      types_hash = {  }

      index_types.each_index do |i|
        key = index_types[i]
        value = index_types[i+1]
        types_hash[key] = value
      end

      types_hash
    end
    def [](index)
      mapping[index]
    end

    def css_classes
      mapping
    end

    def mapping
      @mapping
    end
  end
end
