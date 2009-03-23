require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::Cartographer do

  it "should not visit the same url more then once" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:doit).once.with(origin_url).returns(create_success_result(['http://www.google.com']))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
  end

  it "should not report broken links if there are none" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.stubs(:doit).once.with(origin_url).returns(create_success_result(['http://www.google.com']))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
    cartographer.has_broken_links?.should be_false
  end


  it "should explorer other linked resources" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:doit).with(origin_url).returns(create_success_result(['http://www.google.com/foo.html']))
    Magellan::Explorer.any_instance.expects(:doit).with('http://www.google.com/foo.html').returns(create_success_result([]))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
  end

  it "should only record broken links errors" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.stubs(:doit).with(origin_url).returns(create_success_result(['http://www.google.com/foo.html']))
    Magellan::Explorer.any_instance.stubs(:doit).with('http://www.google.com/foo.html').returns(create_result("404",[]))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
    cartographer.has_broken_links?.should be_true
    cartographer.broken_links.size.should eql(1)
  end

  it "should record 4** errors" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.stubs(:doit).with(origin_url).returns(create_result("404",[]))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
    cartographer.broken_links.first.origin_url.should eql(origin_url)
    cartographer.broken_links.first.status_code.should eql('404')
  end
  
  it "have url and status code in the error message" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.stubs(:doit).with(origin_url).returns(create_result("404",[]))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
    cartographer.failure_message.should include(origin_url)
    cartographer.failure_message.should include("404")
  end
  
  it "should record 5** errors" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.stubs(:doit).with(origin_url).returns(create_result("500",[]))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
    cartographer.broken_links.first.origin_url.should eql(origin_url)
    cartographer.broken_links.first.status_code.should eql('500')
  end

  it "should be able to specify crawlable domains" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:doit).once.with(origin_url).returns(create_success_result(['http://www.foo.com']))
    Magellan::Explorer.any_instance.expects(:doit).once.with('http://www.foo.com').returns(create_success_result(['http://www.bar.com']))
    cartographer = Magellan::Cartographer.new(origin_url, 5,['http://www.google.com','http://www.foo.com'])
    cartographer.crawl
  end

  it "should go n layers deep into a site" do
    origin_url = "http://www.google.com"
    Magellan::Explorer.any_instance.expects(:doit).once.with(origin_url).returns(create_success_result(['http://www.google.com/foo.html']))
    Magellan::Explorer.any_instance.expects(:doit).once.with('http://www.google.com/foo.html').returns(create_success_result(['http://www.google.com/foo2.html']))
    Magellan::Explorer.any_instance.expects(:doit).once.with('http://www.google.com/foo2.html').returns(create_success_result(['http://www.google.com/foo3.html']))
    cartographer = Magellan::Cartographer.new(origin_url,3)
    cartographer.crawl
  end

  it "should use host to determine if we are in a allowed domain" do
    origin_url = "http://www.google.com/jskfjlsajfd"
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.a_domain_we_care_about?("http://www.google.com/index.html").should be_true
  end

  it "should know where a broken link was linked from" do
    origin_url = "http://www.google.com/jskfjlsajfd"
    Magellan::Explorer.any_instance.expects(:doit).with(origin_url).returns(create_success_result(['http://www.google.com/foo.html']))
    Magellan::Explorer.any_instance.expects(:doit).with('http://www.google.com/foo.html').returns(create_result("404",[]))
    cartographer = Magellan::Cartographer.new(origin_url)
    cartographer.crawl
    cartographer.has_broken_links?.should be_true
    cartographer.failure_message.should include(origin_url)
  end

  it "should go through a entire site if layers to explore is set to -1"
  it "should explore n layers into external domains"

  def create_success_result(urls)
    create_result("200",urls)
  end
  
  def create_result(status_code, urls)
    OpenStruct.new({:status_code =>status_code,:linked_resources => urls})
  end
  
end