require 'spec_helper'
require 'go_verbal'
module GoVerbal
  RSpec.describe GoVerbal do
    describe ".css_classes" do
      it "has year" do
        css_classes = GoVerbal.css_classes
        expect(css_classes).to include(:year)
      end

      it "has month" do
        css_classes = GoVerbal.css_classes
        expect(css_classes).to include(:month)
      end

      it "has date" do
        css_classes = GoVerbal.css_classes
        expect(css_classes).to include(:date)
      end

      it "has section" do
        css_classes = GoVerbal.css_classes
        expect(css_classes).to include(:section)
      end

      it "has text_page" do
        css_classes = GoVerbal.css_classes
        expect(css_classes).to include(:text_page)
      end
    end
  end
end
