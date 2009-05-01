require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::Result do

  it "should not remove fragments when converting to absolute urls" do
    results = Magellan::Result.new({:url=>"http://www.google.com/index.html",:destination_url=>"http://www.google.com/index.html",:linked_resources=>["/index.html#foo"]})
    results.absolute_linked_resources.should include("http://www.google.com/index.html#foo")
  end

  it "should use destination_url to build new absolute urls" do
    results = Magellan::Result.new({:url=>"http://www.google.com/bob.html",:destination_url=>"http://www.foo.com/bob.html",:linked_resources=>["/index.html"]})
    results.absolute_linked_resources.should include("http://www.foo.com/index.html")
  end

end