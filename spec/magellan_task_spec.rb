require File.dirname(__FILE__) + '/spec_helper'
require 'rake'

describe "Magellan Tasks" do

  before :all do
    @file_name = File.dirname(__FILE__)  + "/../lib/magellan/rake/magellan_task.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end

  before :each do
    load @file_name
  end

  after :all do
    Rake.application = nil
  end

  it "should create rake spec tasks for all sites" do
    Magellan::Rake::Task.new
    tasks.include?("magellan:explore").should be_true
  end

  it "should explore when task is invoked" do
    Magellan::Rake::Task.new("invoke_task") do |t|
      t.explore_depth = 1
      t.origin_url = "http://localhost:8080"
    end
    Magellan::Explorer.any_instance.expects(:doit).once.with("http://localhost:8080").returns(create_result("200"))
    @rake.invoke_task("invoke_task")
  end

  it "should raise exception when broken links are found" do
    Magellan::Rake::Task.new("exception_task") do |t|
      t.explore_depth = 1
      t.origin_url = "http://canrailsscale.com"
    end
    Magellan::Explorer.any_instance.expects(:doit).once.with("http://canrailsscale.com").returns(create_result("500"))
    lambda {@rake.invoke_task("exception_task")}.should raise_error
  end

  def create_result(status_code)
    OpenStruct.new({:status_code => status_code, :linked_resources => [], :origin_url =>"foo"})
  end


  def tasks
    @rake.tasks.collect{|task| task.name }
  end
end