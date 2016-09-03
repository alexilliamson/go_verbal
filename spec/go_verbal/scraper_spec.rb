require 'spec_helper'
require 'go_verbal/scraper'

module GoVerbal
  RSpec.describe Scraper do
    describe "#collect_date_links" do
      it "sends gpo_site to month" do
        site = double("GPOSiteBrowser", menu_links: [])
        url = double("url")
        date_css_class = double("css_class")
        scraper = Scraper.new(browser: site)
        scraper.date_css_class = date_css_class

        expect(site).to receive(:go_to).with(url).ordered
        expect(site).to receive(:menu_links).with(date_css_class).ordered
        scraper.collect_date_links(url)
      end
    end
  end
end
