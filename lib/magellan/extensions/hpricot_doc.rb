class Hpricot::Doc
  def links_to_other_documents
    links_to_other_resources = [["a","href"],["script","src"]]
    links_to_other_resources.map {|links_to_other_resource| get_attributes(links_to_other_resource.first,links_to_other_resource.last)}.flatten
  end
  
  def get_attributes(tag,attribute)
    (self/tag).map{|alink| alink.attributes[attribute]}.compact
  end
  
end