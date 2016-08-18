require 'spec_helper'
require 'go_verbal'

RSpec.describe "A NavMenu built" do
  context "from the root_page of the GPOSite" do
      it "has every year since 1994" do
        mapper = create_mapper
        home_page_menu = mapper.build

        expect(home_page_menu.years).to eq(years_since_1994)
      end
    end

    def create_mapper
      GoVerbal::NavMenuMapper.new(root_gpo_site)
    end

    def root_gpo_site
      VCR.use_cassette("root_page") do
        GoVerbal::GPOSite.new do |site|
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
