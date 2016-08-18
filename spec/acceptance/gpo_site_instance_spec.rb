require 'spec_helper'
require 'go_verbal'

RSpec.describe "a GPOSite" do
  context "after #go_to_root is called", :vcr do
      it "its current page has content" do
        site = GoVerbal::GPOSite.new
        site.go_to_root

        expect(site.current_page).to have_content
      end

      it "has browse_level_links for every year since_1994" do
        site = GoVerbal::GPOSite.new
        site.go_to_root

        links = site.browse_level_links

        expect(links.size).to eq(years_since_1994.size)
      end
    end

    def years_since_1994
      current_date = Date.today
      current_year = current_date.year
      first_recorded_year = 1994

      (first_recorded_year..current_year).to_a
    end
  end
