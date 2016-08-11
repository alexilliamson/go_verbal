require_relative 'con_record_index/index_date'
require_relative 'con_record_index/crawler'
module GoVerbal
  class ConRecordIndex
    def pages(date:)
      index_date = crawler.go_to_date(date)#IndexDate.new(date: date)

      get_pages_by_date(index_date)
    end

    def crawler
      site = GPOSite.new

      @crawler ||= Crawler.new(site)
    end

    def get_pages_by_date(date)
      page_collection = new_page_collection
      sections = date.sections

      sections.each do |section|
        section_pages = section.text_pages
        page_collection.add_pages(section_pages)
      end

      page_collection.pages
    end

    def new_page_collection
      page_collection.new
    end

    def page_collection
      Struct.new(:pages) do
        def add_pages(pages)
          @pages ||= []
          @pages.concat(pages)
        end

        def pages
          @pages
        end
      end
    end
  end
end
