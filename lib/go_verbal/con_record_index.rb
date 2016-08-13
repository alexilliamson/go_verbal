require_relative 'crawler'

module GoVerbal
  class ConRecordIndex
    def pages(date:)
      nav_menu = crawler.go_to_date(date)#IndexDate.new(date: date)

      get_pages_by_date(nav_menu)
    end

    def crawler
      site = GPOSite.new

      @crawler ||= Crawler.new(site)
    end

    def get_pages_by_date(nav_menu)
      page_collection = new_page_collection
      sections = nav_menu.sections

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
