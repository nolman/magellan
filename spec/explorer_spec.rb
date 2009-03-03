require File.dirname(__FILE__) + '/spec_helper'
require 'magellan/explorer'

describe Magellan::Explorer do

  it "explorer should call back with the status code and other links to explore" do
    result = Magellan::Explorer.new.explore('canrailsscale.com/')
    result.linked_resources.should include('http://pagead2.googlesyndication.com/pagead/show_ads.js')
    result.status_code.should eql('200')
  end
  
end