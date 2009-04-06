require File.dirname(__FILE__) + '/spec_helper'
require 'rake'

describe "Magellan BrokenLinkTask" do

  before :all do
    @file_name = File.dirname(__FILE__)  + "/../lib/magellan/rake/broken_link_task.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end

  before :each do
    load @file_name
    $stdout.stubs(:putc)
  end

  after :all do
    Rake.application = nil
  end

  it "should create a rake task" do
    Magellan::Rake::BrokenLinkTask.new
    tasks.include?("magellan:explore").should be_true
  end

  it "should explore when task is invoked" do
    Magellan::Rake::BrokenLinkTask.new("invoke_task") do |t|
      t.explore_depth = 1
      t.origin_url = "http://localhost:8080"
    end
    Magellan::Explorer.any_instance.expects(:explore_a).once.with("http://localhost:8080").returns(create_result("http://localhost:8080","200"))
    $stdout.expects(:puts) #passed message
    @rake.invoke_task("invoke_task")
  end

  it "should raise exception when broken links are found" do
    Magellan::Rake::BrokenLinkTask.new("exception_task") do |t|
      t.explore_depth = 1
      t.origin_url = "http://canrailsscale.com"
    end
    $stderr.expects(:puts)
    Magellan::Explorer.any_instance.stubs(:explore_a).once.with("http://canrailsscale.com").returns(create_result("http://canrailsscale.com","500"))
    lambda {@rake.invoke_task("exception_task")}.should raise_error
  end
  
  it "should attach logger" do
     Magellan::Rake::BrokenLinkTask.new("logger_test") do |t|
       t.explore_depth = 1
       t.origin_url = "http://canrailsscale.com"
     end
     $stderr.stubs(:puts)
     Magellan::Logger.any_instance.expects(:update)
     Magellan::Explorer.any_instance.stubs(:explore_a).once.with("http://canrailsscale.com").returns(create_result("http://canrailsscale.com","500"))
     lambda {@rake.invoke_task("logger_test")}.should raise_error
   end

  def create_result(url,status_code)
    Magellan::Explorer.create_result(url,url,status_code, [],"foo")
  end

  def tasks
    @rake.tasks.collect{|task| task.name }
  end
end