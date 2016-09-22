module GoVerbal
  class Index
    attr_accessor :mapper
    attr_writer :years, :months

    def initialize(mapper)
      @mapper = mapper
    end

    def years
      @years ||= mapper.load_years
      @years.each
    end

    def months
      collection = years

      enumerate_children(collection)
    end

    def dates
      collection = months

      enumerate_children(collection)
    end

    def sections
      collection = dates
      enumerate_children(collection)
    end

    def text_pages
      enumerate_children(sections)
    end

    def enumerate_children(collection)
      Enumerator.new do |y|
        collection.each do |p|
          subsections = mapper.index_subsections(p)

          subsections.each do |child|
            y << child
          end
        end
      end
    end
  end
end
