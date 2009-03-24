require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::Cartographer do

  it "should not visit the same url more then once" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:explore_a).once.with(origin_url).returns(create_success_result(['http://www.google.com']))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
  end
  
  it "should not visit the same url more then once if they differ by fragment id" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:explore_a).once.with(origin_url).returns(create_success_result(['http://www.google.com#foo']))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
  end
  
  it "should notify observers when a result comes in" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:explore_a).once.with(origin_url).returns(create_success_result(['http://www.google.com']))
    cartographer = Magellan::Cartographer.new(origin_url)
    foo = Object.new
    foo.expects(:update)
    cartographer.add_observer(foo)
    cartographer.crawl
  end

  it "should explorer other linked resources" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:explore_a).with(origin_url).returns(create_success_result(['http://www.google.com/foo.html']))
    Magellan::Explorer.any_instance.expects(:explore_a).with('http://www.google.com/foo.html').returns(create_success_result([]))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
  end

  it "should be able to specify crawlable domains" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:explore_a).once.with(origin_url).returns(create_success_result(['http://www.foo.com']))
    Magellan::Explorer.any_instance.expects(:explore_a).once.with('http://www.foo.com').returns(create_success_result(['http://www.bar.com']))
    cartographer = Magellan::Cartographer.new(origin_url, 5,['http://www.google.com','http://www.foo.com'])
    cartographer.crawl
  end

  it "should go n layers deep into a site" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:explore_a).once.with(origin_url).returns(create_success_result(['http://www.google.com/foo.html']))
    Magellan::Explorer.any_instance.expects(:explore_a).once.with('http://www.google.com/foo.html').returns(create_success_result(['http://www.google.com/foo2.html']))
    Magellan::Explorer.any_instance.expects(:explore_a).once.with('http://www.google.com/foo2.html').returns(create_success_result(['http://www.google.com/foo3.html']))
    cartographer = Magellan::Cartographer.new(origin_url,3)
    cartographer.crawl
  end

  it "should use host to determine if we are in a allowed domain" do
    origin_url = "http://www.google.com/jskfjlsajfd"
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.a_domain_we_care_about?("http://www.google.com/index.html").should be_true
  end
  
  it "should not explore js urls" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:explore_a).once.with(origin_url).returns(create_success_result(["javascript:bookmarksite('ThoughtWorks Studios', 'http://studios.thoughtworks.com')",'http://www.google.com/foo']))
    Magellan::Explorer.any_instance.expects(:explore_a).once.with('http://www.google.com/foo').returns(create_success_result([]))
    cartographer = Magellan::Cartographer.new(origin_url, 5)
    cartographer.crawl
  end
  
  it "should go through a entire site if layers to explore is set to -1"
  it "should explore n layers into external domains"
  
  def create_success_result(linked_resources)
    create_result("200",linked_resources)
  end
  
  def create_result(status_code, linked_resources)
    Magellan::Explorer.create_result("http://www.google.com",status_code,linked_resources)
  end
  
end