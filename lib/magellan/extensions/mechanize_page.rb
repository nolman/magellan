require 'mechanize'
class WWW::Mechanize::Page
  def links_to_other_documents(links_to_other_resources) # :nodoc:
    links_to_other_resources.map {|links_to_other_resource| get_attributes(links_to_other_resource.first,links_to_other_resource.last)}.flatten
  end
  
  def get_attributes(tag,attribute) # :nodoc:
    (self/tag).map{|alink| alink.attributes[attribute]}.compact
  end
end