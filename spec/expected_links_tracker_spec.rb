require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::ExpectedLinksTracker do

  it "should create a error message contianing the offending url and " do
    tracker = Magellan::ExpectedLinksTracker.new([[/.*/,'/about_us.html']])
    tracker.update(Time.now,Magellan::Result.new('200','/fozo',"/bar",[]))
    tracker.errors.first.should include('/fozo')
    tracker.errors.first.should include('/about_us.html')
  end

  it "should be able specify all resource should link to something" do
    tracker = Magellan::ExpectedLinksTracker.new([[/.*/,'/about_us.html']])
    tracker.update(Time.now,Magellan::Result.new('200','/zoro','/zoro',['/about_us.html']))
    tracker.has_errors?.should be_false
    tracker.update(Time.now,Magellan::Result.new('200','/zoro','/zoro',['/about_fail_us.html']))
    tracker.has_errors?.should be_true
  end
  
  it "should only apply rules if they apply to source url" do
    tracker = Magellan::ExpectedLinksTracker.new([[/foo\.html/,'/about_us.html']])
    tracker.update(Time.now,Magellan::Result.new('200','/zoro','/zoro',['/about_fail_us.html']))
    tracker.has_errors?.should be_false
    tracker.update(Time.now,Magellan::Result.new('200','/foo.html','/zoro',['/about_fail_us.html']))
    tracker.has_errors?.should be_true
  end

  it "should only apply rules if they apply to destination url" do
    tracker = Magellan::ExpectedLinksTracker.new([[/foo\.html/,'/about_us.html']])
    tracker.update(Time.now,Magellan::Result.new('200','/zooo','/zoro',['/about_fail_us.html']))
    tracker.has_errors?.should be_false
    tracker.update(Time.now,Magellan::Result.new('200','/zooo','/foo.html',['/about_fail_us.html']))
    tracker.has_errors?.should be_true
  end
  
  it "should know if a expectation was never met" do
    tracker = Magellan::ExpectedLinksTracker.new([[/foo\.html/,'/about_us.html']])
    tracker.update(Time.now,Magellan::Result.new('200','/zooo','/zoro',['/about_fail_us.html']))
    tracker.unmet_expecations?.should be_true
    tracker.update(Time.now,Magellan::Result.new('200','/foo.html','/foo.html',['/about_fail_us.html']))
    tracker.unmet_expecations?.should be_false
  end
  
  it "should provide a meaningfull error message around unmet expectations" do
    tracker = Magellan::ExpectedLinksTracker.new([[/foo\.html/,'/about_us.html']])
    tracker.update(Time.now,Magellan::Result.new('200','/zooo','/zoro',['/about_fail_us.html']))
    tracker.unmet_expecations_messages.should include(/foo\.html/.to_s)
  end
  
  it "should return failed if there are unmet expectations" do
    tracker = Magellan::ExpectedLinksTracker.new([[/foo\.html/,'/about_us.html']])
    tracker.update(Time.now,Magellan::Result.new('200','/zooo','/zoro',['/about_fail_us.html']))
    tracker.failed?.should be_true
    tracker.update(Time.now,Magellan::Result.new('200','/foo.html','/zoro',['/about_us.html']))
    tracker.failed?.should be_false
  end

  it "should return failed if there are failed expectations" do
    tracker = Magellan::ExpectedLinksTracker.new([[/.*/,'/about_us.html']])
    tracker.update(Time.now,Magellan::Result.new('200','/zoro','/zoro',['/about_us.html'])) 
    tracker.failed?.should be_false
    tracker.update(Time.now,Magellan::Result.new('200','/fozo',"/bar",[]))
    tracker.failed?.should be_true
  end

end