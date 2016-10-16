module GoVerbal
  class Index
    attr_accessor :mapper
    attr_writer :years, :months

    def initialize(mapper, options = {})
      @mapper = mapper
      load_existing(options[:load_existing]) if options[:load_existing]
    end

    def load_existing(enums)
      years = enums[:year_enum]
    end

    def years
      @years ||= mapper.load_years
      @years.each
    end

    def months
      @months ||= enumerate_children(years)
    end

    def dates
      @dates ||= enumerate_children(months)
    end

    def sections
      @sections ||= enumerate_children(dates)
    end

    def text_pages(options = {})
      year = options[:year]
      if year
        select_year = years.select{|y| y.value == year}
        @years = select_year
      end
      Enumerator.new do |y|
        years.each do |year|
          month_collection = mapper.index_subsections(year)
          month_collection.each do |month|
            date_collection = mapper.index_subsections(month)
            date_collection.each do |date|
              section_collection = mapper.index_subsections(date)
              section_collection.each do |section|
                text_page_collection = mapper.index_subsections(section)
                text_page_collection.each do |page|
                  y << page
                end
              end
            end
          end
        end
      end

      # text_pages = enumerate_children(sections)
    end

    def enumerate_year_descendents(year)
      year.each_month(mapper) do |month|
        yield month
      end
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
