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

  def tasks
    @rake.tasks.collect{|task| task.name }
  end
end