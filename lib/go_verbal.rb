require 'bundler/setup'
Bundler.require(:default)
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'go_verbal/download'
require 'go_verbal/gpo_site_browser'
require 'go_verbal/directory'
require 'go_verbal/html_text_page'
require 'go_verbal/index'
require 'go_verbal/index_mapper'
require 'go_verbal/page'
require 'go_verbal/scrape_mapping'

Dotenv.load

module GoVerbal
  SECTIONNAMES = ["Daily Digest", "Extensions of Remarks", "House","Senate"]

  def self.download_congressional_record(directory: , options: {})
    mapper = build_index_mapper
    destination = Directory.new(directory)

    Download.new(mapper: mapper, destination: destination, options: options)
  end

  def self.build_index(gpo_site_browser = GPOSiteBrowser.new)
    mapper = build_index_mapper(gpo_site_browser)
    Index.new(mapper)
  end

  def self.build_index_mapper(gpo_site_browser = GPOSiteBrowser.new)
    scraper = Scraper.new(browser: gpo_site_browser, mapping: scrape_mapping)
    IndexMapper.new(scraper: scraper, mapping: scrape_mapping)
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
