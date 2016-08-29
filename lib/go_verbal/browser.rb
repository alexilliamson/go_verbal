require_relative 'internet'

module GoVerbal
  class Browser
    def self.go_to(url)
      response = internet.give_me(url)
      HTMLMenu.new(response)
    end

    def self.internet
      @@internet ||= Internet.new
    end
  end
end
