require 'yaml'

module GoVerbal
  class Directory
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
end
