module GoVerbal
  class Download
    attr_accessor :target_pages, :destination, :mapper

    def initialize(mapper:, destination:, options: )
      @mapper = mapper
      @destination = destination

      # load_inventory(dest)
    end

    def start(options= {})
      target_pages = set_target_pages
      limit = options[:limit]
      counter = 0

      target_pages.each do |page|
        download_page(page)

        counter += 1
        break if counter == limit
      end

    end

    def download_page(page)
      attributes = page.attributes
      file_name = name_file(page)
      destination.write(file_name, attributes)
    end

    def name_file(page)
      url = page.url.to_s
      url.gsub(/https\:\/\/www\.gpo\.gov\/fdsys\/pkg\/.*\/html\//,'').gsub(/\..+$/,'')
    end

    def set_target_pages
      downloaded_inventory = destination.inventory
      index = Index.new(mapper, load_existing: downloaded_inventory)

      index.text_pages
    end
  end
end
