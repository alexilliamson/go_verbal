module GoVerbal
  class Scraper
    attr_accessor :browser, :css_class_names

    def initialize(browser:, mapping: {  })
      @browser = browser
      @css_class_names = mapping.css_classes
    end

    def collect_links(url:, link_type:)
      browser.go_to(url)
      css_params = css_class_names.fetch(link_type)
      query = make_css_query(css_params)

      links = browser.xpath_query(query)
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

    def scrape_content(url)
      browser.go_to(url)
      browser.current_page

      query = "body"
      results = browser.xpath_query(query)
        .first
        .to_s
    end
  end
end
