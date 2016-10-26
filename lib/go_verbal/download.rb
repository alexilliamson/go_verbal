require_relative 'directory'

module GoVerbal
  class Download
    attr_accessor :target_pages, :directory, :mapper, :inventory, :year

    def initialize(directory: , year:)
      @directory = Directory.new(directory)
      @year = year
    end

    def run(index_enumerator: )
      listings = index_enumerator.listings(:year => year)
      counter = 0

      listings.each do |lst|
        if lst.kind_of?(HTMLTextPage)
          download_page(lst)

          yield "#{lst.value} #{lst.date}"
        end
      end
    end

    def download_page(page)
      attributes = page.attributes
      file_name = name_file(page)
      directory.write(file_name, attributes)
    end

    def name_file(page)
      url = page.url.to_s
      url.gsub(/https\:\/\/www\.gpo\.gov\/fdsys\/pkg\/.*\/html\//,'').gsub(/\..+$/,'')
    end
  end
end
