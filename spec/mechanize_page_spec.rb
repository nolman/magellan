require File.dirname(__FILE__) + '/spec_helper'
require 'magellan'

describe "WWW::Mechanize::Page Extensions" do
  LINKS = [["a","href"],["script","src"],["img","src"]]

  it "should not return nil for script tags without src attritubes" do
    doc = WWW::Mechanize::Page.new(nil,{'content-type' => "text/html"},"<script class=foo>something</script>")
    doc.links_to_other_documents(LINKS).should be_empty
  end
  
  it "should find links based on script tags with src attritubes" do
    doc = WWW::Mechanize::Page.new(nil,{'content-type' => "text/html"},"<script class=foo src='foozor'>something</script>")
    links_to_other_documents = doc.links_to_other_documents(LINKS)
    links_to_other_documents.size.should eql(1)
    links_to_other_documents.first.to_s.should eql("foozor")
  end

  it "should be able to get two script sources" do
    doc = WWW::Mechanize::Page.new(nil,{'content-type' => "text/html"},"<body><script class=foo src='foozor'>something</script><script class=foo src='fdsajfkajf'>something</script></body>")
    links_to_other_documents = doc.links_to_other_documents(LINKS)
    links_to_other_documents.size.should eql(2)
  end

  it "should find links based on a tags with href attritubes" do
    doc = WWW::Mechanize::Page.new(nil,{'content-type' => "text/html"},"<a class=foo href='bozo'>something</a>")
    links_to_other_documents = doc.links_to_other_documents(LINKS)
    links_to_other_documents.size.should eql(1)
    links_to_other_documents.first.to_s.should eql("bozo")
  end

  it "should find links based on img tags with src attritubes" do
    doc = WWW::Mechanize::Page.new(nil,{'content-type' => "text/html"},"<img class=foo src='ohno' alt='whatever' />")
    links_to_other_documents = doc.links_to_other_documents(LINKS)
    links_to_other_documents.size.should eql(1)
    links_to_other_documents.first.to_s.should eql("ohno")
  end

  it "should links based on a tags with href attritubes" do
    doc = WWW::Mechanize::Page.new(nil,{'content-type' => "text/html"},"<a class=foo>something</a>")
    doc.links_to_other_documents(LINKS).should be_empty
  end
  
end