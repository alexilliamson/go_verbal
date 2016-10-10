require 'spec_helper'
require 'go_verbal/index_mapper'

module GoVerbal
  RSpec.describe IndexMapper do
    describe "#map_url" do
      context "when type is :text_page" do
        it "uses href" do
          mapping_double = double("Mapping", ordered_index_types: nil)
          mapper = described_class.new(scraper: nil, mapping: mapping_double)
          element = double("Element", type: :text_page, attributes: { href: "google.com" })
          element_type = :text_page

          mapped_url = mapper.map_url(element, element_type)
          expect(mapped_url).to eq(element.attributes["href"])
        end
      end
    end
  end
end
