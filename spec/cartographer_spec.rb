require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::Cartographer do

  it "should not visit the same url more then once" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:explore).once.with(origin_url.to_uri).returns(create_success_result(['http://www.google.com']))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
  end

  it "should explorer other linked resources" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:explore).with(origin_url.to_uri).returns(create_success_result(['http://www.google.com/foo.html']))
    Magellan::Explorer.any_instance.expects(:explore).with('http://www.google.com/foo.html'.to_uri).returns(create_success_result([]))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
  end

  it "should be able to specify crawlable domains" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:explore).once.with(origin_url.to_uri).returns(create_success_result(['http://www.foo.com']))
    Magellan::Explorer.any_instance.expects(:explore).once.with('http://www.foo.com'.to_uri).returns(create_success_result(['http://www.bar.com']))
    cartographer = Magellan::Cartographer.new(origin_url, ['http://www.google.com','http://www.foo.com'])
    cartographer.crawl
  end

  it "should be able to plot a entire site"
  it "should go n layers deep into a site"
  it "should go through a entire site if layers to explore is set to -1"
  it "should explore n layers into external domains"
  it "build a representation of pages and what they link to and the status of those links"

  def create_success_result(uris)
    parsed_uris = uris.collect { |uri| URI.parse(uri)}
    Magellan::Result.new(200,parsed_uris)
  end
end

class String
  def to_uri
    URI.parse(self)
  end
end