require 'spec_helper'
require 'go_verbal/con_record_index'

module GoVerbal
  RSpec.describe ConRecordIndex do
    describe "#get_pages_by_date" do
      context "given a date with sections containing congressional record text" do
        it "returns all sections' pages" do
          date = double
          mock_sections = [create_section_mock, create_section_mock]
          allow(date).to receive(:sections).and_return(mock_sections)

          index = ConRecordIndex.new
          all_mocked_section_pages = mock_sections.map(&:text_pages).flatten

          returned_pages = index.get_pages_by_date(date)

          expect(returned_pages).to eq(all_mocked_section_pages)
        end

        def create_section_mock
          section = double
          allow(section).to receive(:text_pages).and_return(mock_section_pages)


          section
        end

        def mock_section_pages
          [double,double]
        end
      end
    end
  end
end
