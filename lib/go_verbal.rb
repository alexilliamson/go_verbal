require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'go_verbal/congressional_record'
require 'go_verbal/index'
require 'go_verbal/page_update'

Dotenv.load

module GoVerbal
  SECTIONNAMES = ["Daily Digest", "Extensions of Remarks", "House","Senate"]

  def self.congressional_record
    CongressionalRecord.new
  end

  def self.build_index
    Index.new
  end
end
