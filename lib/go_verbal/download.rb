module GoVerbal
  class Download
    attr_accessor :target_pages, :destination

    def initialize(target_pages:, destination: )
      @target_pages = target_pages
      @destination = destination
    end

    def start
      target_pages.each do |page|
          attributes = { url: page.url, content: page.content, title: page.title }

          file_name = page.url.to_s.gsub('https://www.gpo.gov/fdsys/pkg/','').gsub(/\/.+$/,'')
          destination.write(file_name, attributes)
          yield confirmation
      end
    end

    def confirmation
      "confirmed"
    end
  end
end
