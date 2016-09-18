require 'go_verbal/gpo_site_browser'
require 'go_verbal/index'
require 'go_verbal/index_mapper'
require 'go_verbal/scrape_mapping'

module GoVerbal
  SECTIONNAMES = ["Daily Digest", "Extensions of Remarks", "House","Senate"]

  def self.build_index(gpo_site_browser = GPOSiteBrowser.new)
    crawler = Scraper.new(browser: gpo_site_browser, css_class_names: css_classes)
    mapper = IndexMapper.new(crawler, ordered_index_types)
    Index.new(mapper)
  end

  def self.ordered_index_types
    css_classes.keys
  end

  def self.css_classes
    ScrapeMapping.new(
      year: "level1 browse-level",
      month: "level2 browse-level",
      date: "level3 browse-level",
      section: "level4 browse-leaf-level ",
      text_page: "browse-download-links"
    ).
    mapping
  end
end
