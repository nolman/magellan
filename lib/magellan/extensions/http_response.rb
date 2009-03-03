require 'net/http'
class Net::HTTPResponse
  def linked_resources
    body.links.collect { |link| URI.parse(link) }
  end
end