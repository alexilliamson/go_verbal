require 'go_verbal/gpo_site_browser'
require 'go_verbal/index_mapper'

module GoVerbal
  SECTIONNAMES = ["Daily Digest", "Extensions of Remarks", "House","Senate"]

  def self.build_index(gpo_site_browser = GPOSiteBrowser.new)
    crawler = Scraper.new(browser: gpo_site_browser, css_class_names: css_classes)
    IndexMapper.new(crawler)
  end

  def self.css_classes
    {
      year: "level1 browse-level",
      month: "level2 browse-level",
      date: "level3 browse-level",
      section: "level4 browse-leaf-level "
    }
  end
end
