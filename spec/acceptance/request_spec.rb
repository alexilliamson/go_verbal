require 'spec_helper'
require 'go_verbal'
require 'webmock/rspec'

RSpec.describe "making https requests" do
  VCR.use_cassette("urls", :allow_unused_http_interactions => false) do
    year_url = GoVerbal::ROOT_URL
    month_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
    date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
    section_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01/01-25%5C/3&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'

    Net::HTTP.get_response(URI(year_url))
    Net::HTTP.get_response(URI(month_url))
    Net::HTTP.get_response(URI(date_url))
    Net::HTTP.get_response(URI(section_url))
  end

  context "made during year enumeration" do
    it "should be a single request", :vcr do
      WebMock.reset!
      index = GoVerbal.build_index
      year_enumerator = index.years
      expect(WebMock).to  have_requested(:get, GoVerbal::ROOT_URL).once
    end
  end

  context "made during month enumeration" do
    it "should include one request each for a year, and month", :vcr do
      month_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
      month_enumerator = make_month_enumerator

      month_enumerator.next

      expect(WebMock).to  have_requested(:get, GoVerbal::ROOT_URL).once
      expect(WebMock).to have_requested(:get, month_url).once
    end

    def make_month_enumerator
      index = GoVerbal.build_index
      index.months
    end
  end

  context "made during date enumeration" do
    it "should include one request each for a year, month, and date", :vcr do
      month_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
      date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
      date_enumerator = make_date_enumerator

      date_enumerator.next

      expect(WebMock).to  have_requested(:get, GoVerbal::ROOT_URL).once
      expect(WebMock).to have_requested(:get, month_url).once
      expect(WebMock).to have_requested(:get, date_url).once
    end

    def make_date_enumerator
      index = GoVerbal.build_index
      index.dates
    end

  context "made during section enumeration" do
    it "should include one request each for a year, month, date, and section" do
      VCR.use_cassette("urls", :allow_unused_http_interactions => false) do
        year_url = GoVerbal::ROOT_URL
        month_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
        section_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01/01-25%5C/3&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'

        WebMock.reset!
        make_section_enumerator.next
        expect(WebMock).to  have_requested(:get, GoVerbal::ROOT_URL).once
      end
    end

    def make_section_enumerator
      index = GoVerbal.build_index
      index.sections
    end
  end
  end
end
