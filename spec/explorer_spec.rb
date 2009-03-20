require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::Explorer do

  it "should find other js resources" do
    result = Magellan::Explorer.new.explore('http://canrailsscale.com/')
    result.linked_resources.should include('http://pagead2.googlesyndication.com/pagead/show_ads.js')
  end

  it "should find other pages to explore via a href" do
    result = Magellan::Explorer.new.explore('http://www.google.com/')
    result.linked_resources.should include('http://video.google.com/?hl=en&tab=wv')
  end

  it "should translate relative urls to absolute ones" do
    result = Magellan::Explorer.new.explore('http://www.google.com/')
    result.linked_resources.should include('http://www.google.com/intl/en/about.html')
  end

  it "should report non successful status codes" do
    result = Magellan::Explorer.new.explore('http://www.google.com/dfkjaslfkjaslfkj.html')
    result.status_code.should eql("404")
  end

end
