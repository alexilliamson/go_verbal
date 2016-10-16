require 'spec_helper'
require 'go_verbal'

TESTING_DIR = ENV.fetch("TESTING_DIR")

RSpec.describe "a congressional record download to file" do
  before(:each) {remove_existing_test_files}

  it "writes pages to yaml files" do
    remove_existing_test_files

    file_exist = File.exists?("spec/test_files/CREC-1994-01-25-pt1-PgD.yml")
    expect{ download_one_page.call }.to change{Dir.glob(file_match_string).size}.from(0).to(2)
  end

  it "names file from url" do
    download_one_page.call {}
    file_name = Dir.glob(file_match_string).first

    expect(file_name).to eq("spec/test_files/CREC-1994-01-25-pt1-PgD.yml")
  end

  skip "records download progress to inventory.yml" do
    download_one_page.call

    inventory_file = File.join(TESTING_DIR, "inventory.yml")
    yaml = YAML::load_file(inventory_file)
    inventory_list = GoVerbal::InventoryList.new(yaml)

    puts(yaml)
    text_page_inventory = inventory_list.text_pages(date: '1994-01-25', section: "Daily Digest")

    expect(text_page_inventory.size).to eq(1)
  end


  context "after one page has been downloaded" do
    describe "the first request that is made" do
      before do
        VCR.use_cassette("second_text_page", :allow_unused_http_interactions => false) do
          url = 'https://www.gpo.gov/fdsys/pkg/CREC-2016-01-06/html/CREC-2016-01-06-pt1-PgD9-2.htm'
          Net::HTTP.get_response(URI(url))
        end
      end

      VCR.use_cassette("second_text_page") do
        skip "is the next text page link" do
          download = GoVerbal.download_congressional_record(directory: TESTING_DIR)
          second_page_url = :not_a_page


          download.start(limit: 1) do |page|
            second_page_url = page.url
          end

          expect(second_page_url).to eq('https://www.gpo.gov/fdsys/pkg/CREC-2016-01-06/html/CREC-2016-01-06-pt1-PgD9-2.htm')
        end


      end
    end
  end

  def file_match_string
    File.join(TESTING_DIR, "*")
  end

  def remove_existing_test_files
    FileUtils.rm_rf(Dir.glob(file_match_string))
  end

  def download_one_page
    lambda do
      VCR.use_cassette("drill_through_content") do
        download = GoVerbal.download_congressional_record(directory: TESTING_DIR)

        download.start(limit: 1)
      end
    end
  end
end
