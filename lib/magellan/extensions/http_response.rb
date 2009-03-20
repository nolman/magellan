require 'net/http'
class Net::HTTPResponse
  def linked_resources
    body.links.collect do |link|
      URI.parse(link) 
    end
  end
end