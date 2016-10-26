require 'spec_helper'
require 'go_verbal'

TESTING_DIR = ENV.fetch("TESTING_DIR")

RSpec.describe "a congressional record download to file" do
  before(:each) {remove_existing_test_files}

  it "writes pages to yaml files" do
    expect{ download_one_page(1994).call }.to change{File.exists?("spec/test_files/CREC-1994-01-25-pt1-PgD.yml")}.from(false).to(true)
  end

  it "names file from url" do
    download_one_page(1994).call {}
    file_name = Dir.glob(file_match_string).first

    expect(file_name).to eq("spec/test_files/CREC-1994-01-25-pt1-PgD.yml")
  end

  it "saves title, url, date" do
    download_one_page(1994).call {}
    file_name = Dir.glob(file_match_string).first

    file_content = YAML.load_file(file_name)

    expect(file_content.keys).to eq([:url, :title, :date, :section])
  end

  def file_match_string
    File.join(TESTING_DIR, "*")
  end

  def remove_existing_test_files
    FileUtils.rm_rf(Dir.glob(file_match_string))
  end

  def download_one_page(year)
    if year == 1994
      lambda do
          VCR.use_cassette("drill_through_content") do
            congressional_record = GoVerbal.congressional_record
            congressional_record.download(directory: TESTING_DIR, year: year.to_s) do |dl|
              yield dl if block_given?
              break
            end
          end
        end
    else
    end
  end
end
