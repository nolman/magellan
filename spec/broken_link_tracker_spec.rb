require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::BrokenLinkTracker do

  it "should not report broken links if there are none" do
    broken_link_tracker = Magellan::BrokenLinkTracker.new
    broken_link_tracker.update(Time.now,create_success_result('http://www.foo.com',['jalskdjflakjsf']))
    broken_link_tracker.failed?.should be_false
  end

  it "should record links by absolute_url" do
    broken_link_tracker = Magellan::BrokenLinkTracker.new
    broken_link_tracker.update(Time.now,create_success_result('http://www.bozo.com/foople.html',['/apples.html']))
    broken_link_tracker.update(Time.now,create_result('http://www.bozo.com/apples.html',"404",[]))
    broken_link_tracker.failure_message.should  include("http://www.bozo.com/foople.html")
  end

  it "should only record broken links errors" do
    broken_link_tracker = Magellan::BrokenLinkTracker.new
    broken_link_tracker.update(Time.now,create_success_result('http://www.foo.com',['http://www.google.com']))
    broken_link_tracker.update(Time.now,create_result('http://www.foo.com/404',"404",[]))
    broken_link_tracker.failed?.should be_true
    broken_link_tracker.broken_links.size.should eql(1)
  end

  it "should record 4** errors" do
    broken_link_tracker = Magellan::BrokenLinkTracker.new
    broken_link_tracker.update(Time.now,create_result('http://www.foo.com/404',"404",[]))
    broken_link_tracker.broken_links.first.status_code.should eql('404')
  end
  
  it "have url and status code in the error message" do
    broken_link_tracker = Magellan::BrokenLinkTracker.new
    broken_link_tracker.update(Time.now,create_result('broke url',"404",[]))
    broken_link_tracker.failure_message.should include('broke url')
    broken_link_tracker.failure_message.should include("404")
  end
  
  it "should record 5** errors" do
    broken_link_tracker = Magellan::BrokenLinkTracker.new
    broken_link_tracker.update(Time.now,create_result('fooz',"500",[]))
    broken_link_tracker.broken_links.first.status_code.should eql('500')
  end
  
  def create_success_result(url,linked_resources)
    create_result(url,"200",linked_resources)
  end
  
  def create_result(url,status_code, linked_resources)
    Magellan::Result.new(status_code,url,url,linked_resources,"foo")
  end
  
  it "should update the observer with a pass" do
    tracker = Magellan::BrokenLinkTracker.new
    tracker.add_observer(Magellan::Logger.new)
    $stdout.expects(:putc).with('.')
    tracker.update(Time.now,Magellan::Result.new('200','/zoro','/zoro',['/about_us.html'],"text/html")) 
  end
  
  it "should update the observer with a pass" do
    tracker = Magellan::BrokenLinkTracker.new
    tracker.add_observer(Magellan::Logger.new)
    $stdout.expects(:putc).with('F')
    tracker.update(Time.now,Magellan::Result.new('404','/zoro','/zoro',['/fail_about_us.html'],"text/html")) 
  end
end