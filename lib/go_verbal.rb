require 'go_verbal/download'
require 'go_verbal/gpo_site_browser'
require 'go_verbal/html_text_page'
require 'go_verbal/index'
require 'go_verbal/index_mapper'
require 'go_verbal/page'
require 'go_verbal/scrape_mapping'

module GoVerbal
  Dotenv.load
  DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
  FILE_FOLDER = ENV.fetch("FILE_FOLDER")


  SECTIONNAMES = ["Daily Digest", "Extensions of Remarks", "House","Senate"]

  class Directory
    require 'yaml'
    attr_accessor :path
    def initialize(path)
      @path = path
    end

    def write(file_name, data = {})
      file_name = File.join(path, file_name + '.yml')

      File.new(file_name, "w+")
      d = YAML::load_file(file_name) #Load


      File.open(file_name, 'w+') {|f| f.write data.to_yaml }
    end
  end

  def self.download_congressional_record
    index = build_index
    target_pages = index.text_pages

    destination = Directory.new(FILE_FOLDER)

    Download.new(target_pages: target_pages, destination: destination)
  end

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
