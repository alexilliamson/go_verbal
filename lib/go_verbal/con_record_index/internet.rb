require_relative 'html_doc'

module GoVerbal
  class Internet
    def initialize(host, port)
      Net::HTTP.start(host, port) do |connection|
        extract_data(connection)
      end
    end

    def extract_data(connection)
    end

    def html
      HTMLDoc.new
    end
  end
end
