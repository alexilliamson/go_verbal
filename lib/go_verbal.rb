require 'go_verbal/gpo_site_browser'
require 'go_verbal/index'
require 'go_verbal/index_mapper'
require 'go_verbal/scrape_mapping'
require 'go_verbal/text_page'

module GoVerbal
  Dotenv.load
  DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
  SECTIONNAMES = ["Daily Digest", "Extensions of Remarks", "House","Senate"]


  def self.build_index(gpo_site_browser = GPOSiteBrowser.new)
    scraper = Scraper.new(browser: gpo_site_browser, mapping: scrape_mapping)
    mapper = IndexMapper.new(scraper: scraper, mapping: scrape_mapping)
    Index.new(mapper)
  end

  def self.ordered_index_types
    scrape_mapping.css_classes.keys
  end

  def self.scrape_mapping
    ScrapeMapping.new(
      year: [
        div: {  class: "level1 browse-level" }
        ],
      month: [
        div: { class: "level2 browse-level" }
        ],
      date: [
        div: { class:  "level3 browse-level"  }
        ],
      section: [
        div: { class:  "level4 browse-leaf-level "  }
        ],
      text_page: [
       {  table: { class:  "browse-node-table"  } } ,
       {  td: { class:  "browse-download-links", :char_before => "/"   } }
      ]
    )
  end
end
