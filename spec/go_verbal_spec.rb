require 'spec_helper'
require 'go_verbal'
module GoVerbal
  RSpec.describe GoVerbal do
    describe ".build_index" do
      it "loads css_classes into index_mapper" do
        index = GoVerbal.build_index
        css_classes = GoVerbal.css_classes

        expect(index.css_classes).to eq(css_classes)
      end
    end

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
    end
  end
end
