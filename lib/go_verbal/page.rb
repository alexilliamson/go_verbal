module GoVerbal
  class Page
    def self.count
      DB[:pages].count
    end
  end
end
