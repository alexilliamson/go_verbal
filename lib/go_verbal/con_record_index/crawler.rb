require_relative "index_date"

module GoVerbal
  class Crawler
    attr_accessor :site

    def initialize(site)
      @site = site
    end

    def go_to_date(date)
      month = extract_month(date)
      year = extract_year(date)

      site.go_to_root
      site.go_to_year(year)
      site.go_to_month(month)
      site.go_to_date(date)

      site.nav_menu
    end

    def extract_month(date)
      date.month
    end

    def extract_year(date)
      date.year
    end
  end
end
