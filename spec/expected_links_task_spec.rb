require File.dirname(__FILE__) + '/spec_helper'
require 'rake'

describe "Magellan ExpectedLinksTask" do

  before :all do
    @file_name = File.dirname(__FILE__)  + "/../lib/magellan/rake/expected_links_task.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end

  before :each do
    $stdout.stubs(:putc)
    load @file_name
  end

  after :all do
    Rake.application = nil
  end

  it "should create a rake task" do
    Magellan::Rake::ExpectedLinksTask.new
    tasks.include?("magellan:check_links").should be_true
  end

  it "should explore when task is invoked" do
    Magellan::Rake::ExpectedLinksTask.new("some_task") do |t|
      t.explore_depth = 1
      t.patterns_and_expected_links = []
      t.origin_url = "http://localhost:8080"
    end
    $stdout.expects(:puts)
    Magellan::Explorer.any_instance.expects(:explore_a).once.with("http://localhost:8080").returns(create_result("http://localhost:8080","200"))
    @rake.invoke_task("some_task")
  end
  
  
  it "should notify a expected link tracker when a task is invoked" do
    Magellan::Rake::ExpectedLinksTask.new("invoke_expected_link_tracker") do |t|
      t.explore_depth = 1
      t.patterns_and_expected_links = []
      t.origin_url = "http://localhost:8080"
    end
    $stdout.expects(:puts)
    Magellan::Explorer.any_instance.stubs(:explore_a).once.with("http://localhost:8080").returns(create_result("http://localhost:8080","200"))
    Magellan::ExpectedLinksTracker.any_instance.expects(:update).once
    @rake.invoke_task("invoke_expected_link_tracker")
  end
  
  it "should fail the rake task if expected links did not exist or rules did not evaluate to be true" do
    Magellan::Rake::ExpectedLinksTask.new("exception_raising_task") do |t|
      t.explore_depth = 1
      t.patterns_and_expected_links = [[/.*/,'/about_us.html']]
      t.origin_url = "http://canrailsscale.com"
    end
    $stderr.expects(:puts)
    Magellan::Explorer.any_instance.stubs(:explore_a).once.with("http://canrailsscale.com").returns(create_result("http://canrailsscale.com","200"))
    lambda {@rake.invoke_task("exception_raising_task")}.should raise_error
  end
  
  def create_result(url,status_code)
    Magellan::Explorer.create_result(url,url,status_code, [],"text/html")
  end

  def tasks
    @rake.tasks.collect{|task| task.name }
  end
end