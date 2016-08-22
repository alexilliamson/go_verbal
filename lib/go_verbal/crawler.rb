module GoVerbal
  class Crawler
    attr_accessor :gpo_site

    def initialize(gpo_site)
      @gpo_site = gpo_site
    end

    # def visit(index_location)
    # end


    def go_to_root
      gpo_site.go_to_root
      gpo_site
    end

    # def sections
    #   days.each do |day|
    #     days = day.sections
    #     sections.each do |section|
    #       yield section
    #     end
    #   end
    # end

    # def days
    #   months.each do |month|
    #     month.days.each do |day|
    #       yield day
    #     end
    #   end
    # end

    # def months
    #   years.each do |year|
    #     visit(year)
    #     index.months.each do |month|
    #       yield month
    #     end
    #   end
    # end

    # def years
    #   gpo_site.go_to_root
    #   index.years
    # end
  end
end
