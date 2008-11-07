require 'net/http'
class Net::HTTPResponse
  def linked_resources
    body.links
  end
end