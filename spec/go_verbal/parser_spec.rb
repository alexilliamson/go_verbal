require 'spec_helper'
require 'go_verbal/parser'

module GoVerbal
  RSpec.describe Parser do
    describe "#clean_text" do
      it "extracts texts and strips whitespace" do
        element = mock_element
        allow(element).to receive(:text) {  "\t\t\ntext\t\t\n" }
        parser = described_class.new

        extract = parser.clean_text(element)
        expect(extract).to eq("text")
      end
    end

    describe "#extract_url" do
      context "when there is no match result" do
        it "raises an error" do
          element = mock_element
          parser = described_class.new

          expect{ parser.extract_url(element) }.to raise_error("NO MATCHING ONCLICK PATTERN; ELEMENT#{ element.attributes['onclick'] }")
        end
      end

      context "when there is a matching pattern" do
        it "extracts url from onclick" do
          element = mock_element

          allow(element).to receive(:attributes) {  { "onclick" => "goWithVars('/fdsys/browse/collection.action?collectionCode=CREC&browsePath=2016&isCollapsed=false&leafLevelBrowse=false',''); return false;"
          } }
          parser = described_class.new

          extract = parser.extract_url(element)
          expect(extract).to eq("https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=2016&isCollapsed=false&leafLevelBrowse=false")
        end
      end
    end

    def mock_element
      double(text: nil, attributes: {})
    end
  end
end
