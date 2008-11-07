class String
  def links
    patterns = [/href\s*=\s*"*([^\s"]*)/,/src\s*=\s*"*([^\s"]*)/]
    matches = []
    patterns.each do |pattern| 
      matches += self.downcase.scan(pattern).map {|result| result.first} 
    end
    matches
  end
  
  def to_absolute_url(origin_url)
    if self.starts_with?('http://')
      self
    else
      origin_url[/http:\/\/[^\/]*/] + self
    end
  end
end