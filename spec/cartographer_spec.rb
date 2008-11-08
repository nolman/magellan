require 'spec/spec_helper'
require 'magellan/cartographer'

describe Magellan::Cartographer do
  #general todo's not everything belongs in the cartographer
  it "should be able to plot a entire site"
  it "should go n layers deep into a site"
  it "should go through a entire site if layers to explore is set to -1"
  it "should explore n layers into external domains"
  it "should be able to specify crawlable domains"
  it "should not visit the same url more then once"
  it "should report all 404's and the page they were linked from"
  it "build a representation of pages and what they link to and the status of those links"
end