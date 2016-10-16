require 'spec_helper'
require 'go_verbal'

RSpec.describe "a congressional record download" do
  context "given a file directory" do
    it "writes pages to yaml files" do
      VCR.use_cassette("drill_through_content") do
        download = GoVerbal.download_congressional_record

        download.start do |status|
          status
          break
        end

        file_exist = File.exists?("spec/test_files/CREC-1994-01-25.yml")
        expect(file_exist).to be true
      end
    end
  end
end
