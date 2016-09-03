module GoVerbal
  class Parser
    ONLCLICK_MATCHER = /(goWithVars\(\')(?<link_a>\/fdsys.*\?collectionCode.*)\'\,/
    PAGE_DOMAIN = "https://www.gpo.gov"

    def clean_text(element)
      element_text = element.text
      text = element_text.to_s
      text.strip
    end

    def extract_url(element)
      url_source_attribute = "onclick"
      url_source = element.attributes[url_source_attribute]

      url = parse_url_source(url_source)
    end

    def parse_url_source(onclick)
      match = ONLCLICK_MATCHER.match(onclick) || {}

      url = match['link_a'].to_s

      PAGE_DOMAIN + url
    end
  end
end
