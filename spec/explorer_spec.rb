require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe Magellan::Explorer do

  it "explorer should call back with the status code and other links to explore" do
    result = Magellan::Explorer.new.explore(URI.parse('http://canrailsscale.com/'))
    found = result.linked_resources.select { |uri| uri.to_s == 'http://pagead2.googlesyndication.com/pagead/show_ads.js'}
    (found.size == 1).should be_true
    result.status_code.should eql('200')
  end

end
