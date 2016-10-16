require 'bundler/setup'
Bundler.require(:default, :test)
# require 'go_verbal'

RSpec.configure do |config|
  config.before(:all) do
    VCR.use_cassette("drill_through_text_page", :allow_unused_http_interactions => false) do
      year_url = GoVerbal::ROOT_URL
      month_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
      date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
      section_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01/01-25%5C/3&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
      text_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01/01-25%5C/3/DAILYDIGEST&collectionCode=CREC&isCollapsed=false&isDocumentResults=true&leafLevelBrowse=false'

      Net::HTTP.get_response(URI(year_url))
      Net::HTTP.get_response(URI(month_url))
      Net::HTTP.get_response(URI(date_url))
      Net::HTTP.get_response(URI(section_url))
      Net::HTTP.get_response(URI(text_url))
    end
  end

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
