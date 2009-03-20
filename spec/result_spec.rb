require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::Result do

  it "should translate relative urls to absolute ones" do
    result = Magellan::Result.new("http://www.google.com","200",["/intl/en/about.html"])
    result.linked_resources.should include('http://www.google.com/intl/en/about.html')
  end

  it "should not translate absolute urls" do
    result = Magellan::Result.new("http://www.google.com","200",["http://video.google.com/foo/about.html"])
    result.linked_resources.should include("http://video.google.com/foo/about.html")
  end

end
