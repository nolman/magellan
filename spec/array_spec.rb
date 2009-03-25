require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe "Array Extensions" do
  it "should be able to break up a array into chunks with a max size" do
    [1,2,3,4,5].chunk(3).size.should eql(2)
    [1,2,3,4,5].chunk(3).first.should eql([1,2,3])
    [1,2,3,4,5].chunk(3).last.should eql([4,5])
  end
  it "should be able to break up a array into chunks with a max size" do
    [1,2,3,4,5].chunk(1).size.should eql(5)
    [1,2,3,4,5].chunk(1).first.should eql([1])
  end
  
end