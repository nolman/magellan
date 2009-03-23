require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::Explorer do

  it "should find other js resources" do
    result = Magellan::Explorer.new('http://canrailsscale.com/').explore
    result.linked_resources.should include('http://pagead2.googlesyndication.com/pagead/show_ads.js')
  end

  it "should find other pages to explore via a href" do
    result = Magellan::Explorer.new('http://www.google.com/').explore
    result.linked_resources.should include('http://video.google.com/?hl=en&tab=wv')
  end

  it "should translate relative urls to absolute ones" do
    result = Magellan::Explorer.new('http://www.google.com/').explore
    result.linked_resources.should include('http://www.google.com/intl/en/about.html')
  end

  it "should report non successful status codes" do
    result = Magellan::Explorer.new('http://www.google.com/dfkjaslfkjaslfkj.html').explore
    result.status_code.should eql("404")
  end

  it "should translate relative urls to absolute ones" do
    explorer = Magellan::Explorer.new("http://www.google.com")
    explorer.convert_to_absolute_urls("200",["/intl/en/about.html"]).linked_resources.should include('http://www.google.com/intl/en/about.html')
  end

  it "should not translate absolute urls" do
    explorer = Magellan::Explorer.new("http://www.google.com")
    explorer.convert_to_absolute_urls("200",["http://video.google.com/foo/about.html"]).linked_resources.should include("http://video.google.com/foo/about.html")
  end

end
