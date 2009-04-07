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
  it "should create a log file if one is passed in and the updated failed" do
    begin
      log = File.dirname(__FILE__) + "/log.txt"
      FileUtils.rm(log,:force => true)
      File.exists?(log).should be_false
      $stdout.stubs(:putc)
      logger =Magellan::Logger.new(log)
      logger.update(Time.now,false,'foozor')
      File.exists?(log).should be_true
      File.open(log).readlines.should include("foozor\n")
    ensure
      FileUtils.rm(log,:force => true)
    end
  end

  it "should not a log file if one is passed in and the updated passed" do
    log = File.dirname(__FILE__) + "/log2.txt"
    FileUtils.rm(log,:force => true)
    File.exists?(log).should be_false
    $stdout.stubs(:putc)
    logger =Magellan::Logger.new(log)
    logger.update(Time.now,true,'foozor')
    File.exists?(log).should be_false
  end

end
