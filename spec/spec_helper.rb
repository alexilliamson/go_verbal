require 'bundler/setup'
Bundler.require(:test)

require 'factories'

RSpec.configure do |config|
  config.color = true

  config.include FactoryGirl::Syntax::Methods

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end


VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  # c.hook_into :webmock
  c.configure_rspec_metadata!
end
