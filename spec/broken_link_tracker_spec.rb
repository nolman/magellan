require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::BrokenLinkTracker do

  it "should not report broken links if there are none" do
    broken_link_tracker = Magellan::BrokenLinkTracker.new
    broken_link_tracker.update(Time.now,create_success_result('fooz',['jalskdjflakjsf']))
    broken_link_tracker.has_broken_links?.should be_false
  end

  it "should only record broken links errors" do
    broken_link_tracker = Magellan::BrokenLinkTracker.new
    broken_link_tracker.update(Time.now,create_success_result('fooz',['http://www.google.com']))
    broken_link_tracker.update(Time.now,create_result('fooz',"404",[]))
    broken_link_tracker.has_broken_links?.should be_true
    broken_link_tracker.broken_links.size.should eql(1)
  end

  it "should record 4** errors" do
    broken_link_tracker = Magellan::BrokenLinkTracker.new
    broken_link_tracker.update(Time.now,create_result('fooz',"404",[]))
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

  it "should know where a broken link was first linked from" do
    broken_link_tracker = Magellan::BrokenLinkTracker.new
    broken_link_tracker.update(Time.now,create_result('bar',"200",['fooz']))
    broken_link_tracker.update(Time.now,create_result('zoro',"200",['fooz']))
    broken_link_tracker.update(Time.now,create_result('fooz',"500",[]))
    broken_link_tracker.failure_message.should include("bar")
    broken_link_tracker.failure_message.should_not include("zoro")
  end
  
  def create_success_result(url,linked_resources)
    create_result(url,"200",linked_resources)
  end
  
  def create_result(url,status_code, linked_resources)
    Magellan::Result.new(status_code,url,url,linked_resources)
  end
end