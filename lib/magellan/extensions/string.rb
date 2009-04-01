require 'activesupport'
require 'open-uri'
class String
  def to_absolute_url(origin_url)
    begin
      #BUG in URI.join?  URI.join('http://www.google.com/index.html?foo=b','?foo=a') # => http://www.google.com/?foo=a
      stripped = self.strip
      if stripped.starts_with?('?')
        origin_url.gsub(/\?.*/,'') + stripped
      else
        URI.join(origin_url,stripped).to_s
      end
    rescue
      self
    end
  end

  def remove_fragment
    self.gsub(/#.*/,'')
  end
end
