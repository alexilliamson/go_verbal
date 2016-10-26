module GoVerbal
  class ScrapeMapping
    def initialize
      @mapping = {
        :year => "div[@class='level1 browse-level']/a",
        :month => "div[@class='level2 browse-level']/a",
        :date => "div[@class='level3 browse-level']/a",
        :section => "div[@class='level4 browse-leaf-level ']/a",
        :text_page => "table[@class='browse-node-table']//td[@class='browse-download-links']/a"
      }
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

    def mapping
      @mapping
    end

    def get_css_query(link_type)
      css_params = mapping.fetch(link_type)
    end
  end
end
