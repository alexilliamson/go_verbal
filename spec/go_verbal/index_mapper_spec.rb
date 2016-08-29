require 'spec_helper'

module GoVerbal
  RSpec.describe IndexMapper do
    describe "#load_months" do
      it "sends gpo_site to year url" do
        year_url = double("YearURL")
        year = double(url: year_url)
        gpo_site = instance_double(GPOSiteBrowser, menu_links: [])

        mapper = described_class.new(gpo_site)

        mapper.years = [year].each
        expect(gpo_site).to receive(:go_to).with(year_url)


        mapper.load_months
      end
    end
  end
end
