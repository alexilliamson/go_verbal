require 'spec_helper'
require 'go_verbal/index_mapper'

module GoVerbal
  RSpec.describe IndexMapper do
    describe "#parse" do
      it "extracts texts and strips whitespace" do
        text = double
        element = double(text: "\t\t\ntext\t\t\n")
        nav_menu_mapper = described_class.new

        extract = nav_menu_mapper.parse(element)
        expect(extract).to eq("text")
      end
    end
  end
end
