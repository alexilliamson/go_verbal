require_relative 'index_mapper'

module GoVerbal
  class Index
    attr_accessor :mapper

    def initialize
      @mapper = IndexMapper.new
    end

    def listings(year: 1994)
      years = root_menu_item.first_descendents

      if year
        select_year = years.select{|y| y.value == year.to_s}
        years = select_year
      end

      Enumerator.new do |y|
        years.each do |yr|
          y << yr
          month_collection = yr.each_descendent { |desc| y << desc}
        end
      end
    end

    def root_menu_item
      @root_menu_item ||= mapper.root_menu_item
    end
  end
end
