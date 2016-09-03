require 'spec_helper'
require 'go_verbal'

RSpec.describe "an index" do
  context "built from the root page of the GPOSite", :vcr do
    it "has every year since 1994" do
      index = GoVerbal.build_index
      years = index.years

      expect(years.map(&:value)).to eq(years_since_1994)
    end
  end

  def root_gpo_site
    VCR.use_cassette("root_page") do
      GoVerbal::GPOSiteBrowser.new do |site|
        site.go_to_root
      end
    end
  end

  def years_since_1994
    current_date = Date.today
    current_year = current_date.year
    first_recorded_year = 1994

    years = (first_recorded_year..current_year).to_a

    years.map(&:to_s)
  end
end
