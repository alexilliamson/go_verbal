require 'spec_helper'

module GoVerbal
  RSpec.describe HTMLDoc do
    describe "#div" do
      css_class = "level1 browse-level"
      context "given :css_class => #{css_class}" do
        it "sends css message to its content with div.#{css_class}" do
          content = double
          html = HTMLDoc.new(content)

          expect(content).to receive(:css).with("div." + css_class)

          html.div( :css_class => css_class)
        end
      end
    end
  end
end
