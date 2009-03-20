require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe "Hpricot Extensions" do

  it "should not return nil for script tags without src attritubes" do
    doc = Hpricot("<script class=foo>something</script>")
    doc.links_to_other_documents.should be_empty
  end
  
  it "should find links based on script tags with src attritubes" do
    doc = Hpricot("<script class=foo src='foozor'>something</script>")
    links_to_other_documents = doc.links_to_other_documents
    links_to_other_documents.size.should eql(1)
    links_to_other_documents.first.should eql("foozor")
  end

  it "should find links based on a tags with href attritubes" do
    doc = Hpricot("<a class=foo href='bozo'>something</a>")
    links_to_other_documents = doc.links_to_other_documents
    links_to_other_documents.size.should eql(1)
    links_to_other_documents.first.should eql("bozo")
  end

  it "should find links based on img tags with src attritubes" do
    doc = Hpricot("<img class=foo src='ohno' alt='whatever' />")
    links_to_other_documents = doc.links_to_other_documents
    links_to_other_documents.size.should eql(1)
    links_to_other_documents.first.should eql("ohno")
  end

  it "should links based on a tags with href attritubes" do
    doc = Hpricot("<a class=foo>something</a>")
    doc.links_to_other_documents.should be_empty
  end
  
end