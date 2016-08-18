require 'spec_helper'

module GoVerbal
  RSpec.describe HTMLDoc do
    describe "#div" do
      css_class = "level1 browse-level"
      context "given :css_class => #{css_class}" do
        it "sends css message to its content with div.#{css_class}" do
          content = instance_double(NokogiriHTMLDocWrapper)
          html = HTMLDoc.new(content)

          expect(content).to receive(:css).with("div[@class='" + css_class + "']")

          html.div( :css_class => css_class)
        end
      end
    end

    describe "#has_content?" do
      context "when length is greater than 0" do
        it "is true" do
          content = instance_double(NokogiriHTMLDocWrapper, length: 1)
          html = HTMLDoc.new(content)

          expect(html.has_content?).to be true
        end
      end
    end
  end
end
