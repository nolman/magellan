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

  it "should not get any links if it not a text/xhtml file" do
    result = Magellan::Explorer.new("http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js").explore
    result.linked_resources.should be_empty
  end

  it "should update url if redirected" do
    result = Magellan::Explorer.new("http://www.thoughtworks.com/mingle").explore
    result.url.should eql("http://studios.thoughtworks.com/mingle-agile-project-management")
  end

  it "should not remove fragments when converting to absolute urls" do
    results = Magellan::Explorer.create_result("http://www.google.com/index.html","200",["/index.html#foo"])
    results.linked_resources.should include("http://www.google.com/index.html#foo")
  end
  
end