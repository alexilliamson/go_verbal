require 'yaml'
require_relative 'inventory_list'
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

    def with_inventory
      yield inventory
    end

    def inventory
      @inventory ||= load_inventory_list
    end

    def load_inventory_list
      inventory_file = File.join(path, "inventory.yml")

      if File.exists?(inventory_file)
        inventory_config = YAML::load_file(inventory_file)
      else
        File.new(inventory_file, "w+")
        inventory_config = {}
      end

      InventoryList.new(inventory_config)
    end
  end
end
