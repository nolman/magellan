require 'spec/spec_helper'
require 'magellan/extensions/string'

describe "String Extensions" do
  it "should get all anchor href links out of a string" do
    input = 'fjkasjfklasjflksjf <a href="http://www.nytimes.com/2008/11/06/us/politics/07elect.html?hp">Rahm Emanuel Accepts Post as White House Chief of Staff</a> akfj <a class="offsite ct-lifestyle" href="/services/">The Ultimate Guide to Stress Relief</a>'
    input.links.should include('/services/')
    input.links.should include('http://www.nytimes.com/2008/11/06/us/politics/07elect.html?hp')
  end
  
  it "should get all src links out of a string" do
    input = ' <script type="text/javascript" src="/Test_Automation_Framework/chrome/common/js/trac.js"></script></head><body>'
    input.links.should include('/Test_Automation_Framework/chrome/common/js/trac.js')
  end
  
end