require 'activesupport'
require 'open-uri'
class String
  
  # Converts a relative url to a absolute url
  # Example:
  #  '/foo.html'.to_absolute_url('http://www.google.com/index.html?foo=b')    # => http://www.google.com/foo.html
  #  '?foo=a'.to_absolute_url('http://www.google.com/index.html?foo=b')    # => http://www.google.com/index.html?foo=a
  def to_absolute_url(origin_url) # :nodoc:
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

  # Removes a fragment from a URL
  # Example:
  #  '/foo.html#fsajfksafd'.remove_fragment    # => /foo.html
  def remove_fragment
    self.gsub(/#.*/,'')
  end
end
