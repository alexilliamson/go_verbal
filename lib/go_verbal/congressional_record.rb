require_relative 'download'
module GoVerbal
  class CongressionalRecord
    def download(directory: , year: )
      download = Download.new(directory: directory, year: year)
      index_enumerator = Index.new

      download.run(index_enumerator: index_enumerator) do |dl|
        yield dl
      end
    end
  end
end
