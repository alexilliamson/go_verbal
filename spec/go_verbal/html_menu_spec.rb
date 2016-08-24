require 'spec_helper'

module GoVerbal
  RSpec.describe HTMLMenu do
    describe "#class_selector_string" do
      css_class = "level1 browse-level"
      context "given :css_class => #{css_class}" do
        it "= div.#{css_class}/a" do
          html = described_class.new(nil)

          selector = html.class_selector_string(:div, css_class)

          expect(selector).to eq("div[@class='level1 browse-level']/a")
        end
      end
    end

    describe "#has_content?" do
      context "when length is greater than 0" do
        it "is true" do
          content = "YAYAYAYAYY"
          html = described_class.new(content)

          expect(html.has_content?).to be true
        end
      end
    end
  end
end
