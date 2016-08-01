require_relative "gpo_site"

module GoVerbal
  class NavMenu
    class SectionMapper
      def import_sections(page)
      end
    end

    def sections(date)
      url = date.url
      section_mapper = new_section_mapper
      page = gpo_site.get_page(url: url)

      section_mapper.import_sections(page)
    end

    def gpo_site
      GPOSite.new
    end

    def new_section_mapper
      SectionMapper.new
    end
  end
end
