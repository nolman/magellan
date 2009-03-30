require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::Result do

  it "should not remove fragments when converting to absolute urls" do
    results = Magellan::Result.new("200","http://www.google.com/index.html","http://www.google.com/index.html",["/index.html#foo"])
    results.absolute_linked_resources.should include("http://www.google.com/index.html#foo")
  end

  it "should use destination_url to build new absolute urls" do
    results = Magellan::Result.new("200","http://www.google.com/bob.html","http://www.foo.com/bob.html",["/index.html"])
    results.absolute_linked_resources.should include("http://www.foo.com/index.html")
  end

end