require 'spec/spec_helper'
require 'magellan/explorer'

describe Magellan::Explorer do
  it "explorer should call back with the status code and other links to explore" do
    status_code = nil
    links = nil
    explorer = Magellan::Explorer.new('http://canrailsscale.com/') do |code,l|
      status_code = code
      links = l
    end
    explorer.explore
    links.should include('http://www.google-analytics.com/ga.js')
  end
  
end