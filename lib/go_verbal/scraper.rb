module GoVerbal
  class Scraper
    attr_accessor :site, :css_class_names

    def initialize(browser:, css_class_names: {})
      @site = browser
      @css_class_names = css_class_names
    end

    def find_months(index_mapper)
      years = index_mapper.years
      years.each do |year|
        url = year.url
        collect_links(link_type: :month, url: url) do |element|
          yield element
        end
      end
    end

    def find_dates(index_mapper)
      months = index_mapper.months
      months.each do |month|
        url = month.url
        collect_links(link_type: :date, url: url) do |element|
          yield element
        end
      end
    end

    def collect_year_links
      site.go_to_root

      menu_links(site, :year)
    end

    def collect_month_links(url)
      collect_links(link_type: :month, url: url) {|link| yield link}
    end

    def collect_date_links(url)
      collect_links(link_type: :date, url: url) {|link| yield link}
    end

    def collect_links(link_type:, url:)
      site.go_to(url)
      menu_links(site, link_type).each do |link|
        yield link
      end
    end

    def date_css_class=(css_class)
      css_class_names[:date] = css_class
    end

    def menu_links(gpo_site, level_description)
      css_class = css_class_names[level_description]#{}"level1 browse-level"
      gpo_site.menu_links(css_class)
    end
  end
end
