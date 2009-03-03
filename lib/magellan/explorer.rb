require 'net/http'
require 'magellan/extensions/string'
require 'magellan/extensions/http_response'

module Magellan
  class Explorer
    def explore(url)
      response = web_response(url)
      Result.new(response.code,response.linked_resources)
    end
    def web_response(uri)
      #TODO: fix proxy support
      req = Net::HTTP::Get.new(uri.path)
      res = nil
      Net::HTTP.start(uri.host,uri.port) {|http|
        res = http.request(req)
      }
      res
    end
  end
end