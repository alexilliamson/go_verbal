require 'spec_helper'
require 'go_verbal/index_mapper'

module GoVerbal
  RSpec.describe IndexMapper do
    describe "#map_url" do
      context "when type is :text_page" do
        it "uses href" do
          mapper = described_class.new
          element = double("Element", type: :text_page, attributes: { "href" => "google.com" })
          element_type = :text_page

          mapped_url = mapper.map_url(element, element_type)
          expect(mapped_url).to eq(element.attributes["href"])
        end
      end

      context "when type is something else" do
        it "extracts url from onclick" do
          element = mock_element

          allow(element).to receive(:attributes) {  { "onclick" => "goWithVars('/fdsys/browse/collection.action?collectionCode=CREC&browsePath=2016&isCollapsed=false&leafLevelBrowse=false',''); return false;"
          } }

          mapper = described_class.new

          extract = mapper.map_url(element, type: :something_else)
          expect(extract).to eq("https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=2016&isCollapsed=false&leafLevelBrowse=false")
        end
      end
    end

    describe "#clean_text" do
      it "extracts texts and strips whitespace" do
        element = mock_element
        allow(element).to receive(:text) {  "\t\t\ntext\t\t\n" }

        mapper = described_class.new
        extract = mapper.clean_text(element)

        expect(extract).to eq("text")
      end
    end

    def mock_element
      double(text: nil, attributes: {})
    end
  end
end
