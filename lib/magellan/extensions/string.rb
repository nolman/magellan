class String
  def links
    pattern = /href\s*=\s*"*([^\s"]*)/
    self.scan(pattern).map {|result| result.first}
  end
end