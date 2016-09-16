module GoVerbal
  class Scraper
    attr_accessor :site, :css_class_names

    def initialize(browser:, css_class_names: {})
      @site = browser
      @css_class_names = css_class_names
    end

    def root_index_item
      OpenStruct.new(:url => ROOT_URL, child_type: :year)
    end

    def find_dates(index_mapper)
      months = index_mapper.months
      months.each do |month|
        collect_links(month) do |element|
          yield element
        end
      end
    end

    def collect_year_links
      to_enum(:collect_child_links, root_index_item)
    end

    def collect_child_links(index_item)
      url = index_item.url
      link_type = index_item.child_type
      site.go_to(url)

      css_class = css_class_names[link_type]#{}"level1 browse-level"
      links = site.menu_links(css_class)

      if links.empty?
        raise "#{site} #{url} HAS NO MENU_LINKS FOR CSS CLASS[#{css_class_names[link_type]}]"
      else
        links.each  {|link| yield link}
      end
    end
  end
end
