require 'spec_helper'
require 'go_verbal'
module GoVerbal
  RSpec.describe GoVerbal do
    describe ".css_classes" do
      it "has year" do
        scrape_mapping = GoVerbal.scrape_mapping
        css_classes = scrape_mapping.css_classes
        expect(css_classes).to include(:year, :month, :date, :section, :text_page)
      end
    end
  end
end
