require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::Logger do
  it "should put a . for a pass" do
    logger = Magellan::Logger.new
    $stdout.expects(:putc).with('.')
    logger.update(Time.now,true,'')
  end
  it "should put a F for a fail" do
    logger = Magellan::Logger.new
    $stdout.expects(:putc).with('F')
    logger.update(Time.now,false,'')
  end
end