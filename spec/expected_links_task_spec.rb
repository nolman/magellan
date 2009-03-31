require File.dirname(__FILE__) + '/spec_helper'
require 'rake'

describe "Magellan Tasks" do

  before :all do
    @file_name = File.dirname(__FILE__)  + "/../lib/magellan/rake/expected_links_task.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end

  before :each do
    load @file_name
  end

  after :all do
    Rake.application = nil
  end

  it "should create a rake task" do
    Magellan::Rake::ExpectedLinksTask.new
    tasks.include?("magellan:check_links").should be_true
  end


  def create_result(url,status_code)
    Magellan::Explorer.create_result(url,url,status_code, [])
  end

  def tasks
    @rake.tasks.collect{|task| task.name }
  end
end