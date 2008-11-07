require 'spec/spec_helper'
require 'magellan/explorer'

describe Magellan::Explorer do
  it "explorer should call back with the status code and other links to explore" do
    status_code = nil
    links = nil
    explorer = Magellan::Explorer.new('canrailsscale.com/') do |code,l|
      status_code = code
      links = l
    end
    explorer.explore
    links.should include('http://pagead2.googlesyndication.com/pagead/show_ads.js')
    status_code.should eql('200')
  end
  
end