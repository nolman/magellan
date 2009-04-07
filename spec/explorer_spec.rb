require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::Explorer do

  it "should find other js resources" do
    result = Magellan::Explorer.new(['http://canrailsscale.com/'],links_to_explore).explore
    result.first.absolute_linked_resources.should include('http://pagead2.googlesyndication.com/pagead/show_ads.js')
  end
  
  it "should foo" do
    WWW::Mechanize.any_instance.expects(:get).raises(Timeout::Error)
    result = Magellan::Explorer.new(['http://canrailsscale.com/'],links_to_explore).explore
    result.first.status_code.should eql('504')
    result.first.url.should eql('http://canrailsscale.com/')
  end

  it "should have one result for one url" do
    result = Magellan::Explorer.new(['http://www.google.com/'],links_to_explore).explore
    result.size.should eql(1)
  end

  it "should have two results for two urls" do
    result = Magellan::Explorer.new(['http://www.google.com/','http://www.apple.com/'],links_to_explore).explore
    result.size.should eql(2)
  end

  it "should find other pages to explore via a href" do
    result = Magellan::Explorer.new('http://www.google.com/',links_to_explore).explore
    result.first.absolute_linked_resources.should include('http://video.google.com/?hl=en&tab=wv')
  end

  it "should translate relative urls to absolute ones" do
    result = Magellan::Explorer.new('http://www.google.com/',links_to_explore).explore
    result.first.absolute_linked_resources.should include('http://www.google.com/intl/en/about.html')
  end

  it "should report non successful status codes" do
    result = Magellan::Explorer.new('http://www.google.com/dfkjaslfkjaslfkj.html',links_to_explore).explore
    result.first.status_code.should eql("404")
  end

  it "should not get any links if it not a text/xhtml file" do
    result = Magellan::Explorer.new("http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js",links_to_explore).explore
    result.first.absolute_linked_resources.should be_empty
  end

  it "should update url if redirected" do
    result = Magellan::Explorer.new("http://www.thoughtworks.com/mingle",links_to_explore).explore
    result.first.destination_url.should eql("http://studios.thoughtworks.com/mingle-agile-project-management")
  end

  it "should return source url as desintation url if a error occurs" do
    result = Magellan::Explorer.new("http://www.google.com/dfkjaslfkjaslfkj.html",links_to_explore).explore
    result.first.destination_url.should eql("http://www.google.com/dfkjaslfkjaslfkj.html")
  end

  it "should be able to explore a url" do
    Magellan::Explorer.new('',links_to_explore).explore_a("http://www.yahoo.com")
  end

  it "should be able to go from http to https" do
    result = Magellan::Explorer.new("http://mail.yahoo.com",links_to_explore).explore
    result.first.destination_url.starts_with?("https://").should be_true
  end
  
  it "should be able to crawl ftp based links"

  def links_to_explore
    [["a","href"],["script","src"],["img","src"]]
  end
end