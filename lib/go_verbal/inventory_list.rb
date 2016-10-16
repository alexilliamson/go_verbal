module GoVerbal
  class InventoryList
    attr_accessor :inventory
    def initialize(config)
      @inventory = read_config(config)
    end

    def read_config(config)
      config
    end

    def text_pages(date:, section:)
      date = Date.parse(date)
      date_inv = get_inventory(date)
      date_inv[section]
    end

    def get_inventory(date)
      year = date.year
      month = date.month

      year_inv = inventory.fetch(year)
      month_inv = year_inv[month]

      month_inv(date)
    end

    # def read_i

    def log(data)
      # data[:type]
      # year = data[:year]
      # month = data[:month]
      # date = data[:date]
      # section = data[:section]
      # url = data[:url]

      # inventory_list.[year][month][date][section][url][:status] = :complete
    end

    def [](key)
      inventory[key]
    end
  end
end
