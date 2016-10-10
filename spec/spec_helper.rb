require 'bundler/setup'
Bundler.require(:default, :test)

RSpec.configure do |config|
  config.color = true

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
