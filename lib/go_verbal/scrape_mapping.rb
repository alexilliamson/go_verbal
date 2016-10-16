module GoVerbal
  class ScrapeMapping
    def initialize(args)
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

    def css_classes
      mapping
    end

    def mapping
      @mapping
    end

    def get_css_query(link_type)
      css_params = mapping.fetch(link_type)
    end

    def make_css_query(params)
      query = ""

      params.each do |p|
        if p.kind_of?(Hash)
          selector_string = map_params(p)
        else
          p_string = p.to_s
          selector_string = p_string
        end

        query = query << selector_string  + "/"
      end

      return query + "a"
    end

    def map_params(options)
      tag = options.keys.first

      attr_hash = options.values.first
      attr_string = tag.to_s
      attr_hash.each do |k,v|
        attr_string = modify_attr_string(attr_string, k, v)
      end

      return attr_string
    end

    def modify_attr_string(attr_string, key, value)
      if key == :class
        attr_string + "[@#{ key }='#{ value }" + "']"
      elsif key == :char_before
        value << attr_string
      end
    end
  end
end
