require 'spec_helper'
require 'go_verbal/scraper'

module GoVerbal
  RSpec.describe Scraper do
    describe "#collect_links" do
      context "when GPO doesn't have menu_links with matching css_class" do
        skip "raises an error with the css_class and url" do
          site = double("GPOSiteBrowser", go_to: nil, menu_links: [])
          url = url
          css_class = double("css_class")
          css_class_lookup = double("lookup")

          css_classes = {css_class_lookup => css_class}

          scraper = Scraper.new(browser: site, css_class_names: css_classes)


          expect do
            scraper.collect_links(link_type: css_class_lookup, url: url)
          end.to raise_error("#{site} #{url} HAS NO MENU_LINKS FOR CSS CLASS[#{css_class}]")
        end
      end
    end
  end
end
