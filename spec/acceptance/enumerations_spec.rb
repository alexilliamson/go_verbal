require 'spec_helper'
require 'go_verbal'

RSpec.describe "an enumerated item from the index" do
  describe "a year", :vcr do
    it "has a url from the GPOSite domain" do
      index = GoVerbal.build_index
      years = index.years
      year = years.next
      expect(year.url).to start_with("https://www.gpo.gov/fdsys/browse/")
    end
  end
end
