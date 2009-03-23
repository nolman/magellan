require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::Result do
  
  it "should equate if they are the same url" do
    result = Magellan::Result.new("foo","200")
    result.should eql("foo")
  end

  it "should not equate if they are not the same url" do
    result = Magellan::Result.new("fooz","200")
    result.should_not eql("foo")    
  end

end
