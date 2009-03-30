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
    tracker.errors.empty?.should be_true
    tracker.update(Time.now,Magellan::Result.new('200','/zoro','/zoro',['/about_fail_us.html']))
    tracker.errors.empty?.should be_false
  end
  
  it "only apply rules if they apply"
  
  it "should fail if a expectation was never met"
  
end