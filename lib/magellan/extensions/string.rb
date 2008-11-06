class String
  def links
    patterns = [/href\s*=\s*"*([^\s"]*)/,/src\s*=\s*"*([^\s"]*)/]
    matches = []
    patterns.each do |pattern| 
      matches += self.scan(pattern).map {|result| result.first} 
    end
    matches
  end
  
  def to_absolute_url(origin_url)
    origin_url + self
  end
end