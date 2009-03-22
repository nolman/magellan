require 'activesupport'

class String  
  def to_absolute_url(origin_url)
    if self.starts_with?('http://') || self.starts_with?('https://')
      self
    else
      origin_url[/https*:\/\/[^\/]*/] + self
    end
  end
end