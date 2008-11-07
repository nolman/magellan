require 'net/http'
require 'magellan/extensions/string'
require 'magellan/extensions/http_response'

module Magellan
  class Explorer
    def initialize(url, &block)
      @url=url
      @block=block
    end
    
    def explore
      response = web_response
      @block.call(response.code,response.linked_resources)
    end
    
    def web_response
      #TODO: fix proxy support
      proxy_addr = '10.8.77.100'
      proxy_port = 8080
      url = URI.parse("http://#{@url}")
      puts url
      req = Net::HTTP::Get.new(url.path)
      res = nil
      Net::HTTP::Proxy(proxy_addr, proxy_port).start(@url) {|http|
        res = http.request(req)
      }
      res
    end
  end
end