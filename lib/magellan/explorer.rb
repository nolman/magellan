require 'net/http'

module Magellan
  class Explorer
    def initialize(url, &block)
      @url=url
      @block=block
    end
    def explore
      response = web_response
      @block.call(response,response.body.links)
    end
    
    def web_response
      #TODO: fix proxy support
      proxy_addr = '10.8.77.100'
      proxy_port = 8080
      puts "url#{@url}"
      url = URI.parse(@url)
      puts url
      req = Net::HTTP::Get.new(url.path)
      res = Net::HTTP::Proxy(proxy_addr, proxy_port).start(@url) {|http|
        http.request(req)
      }
      puts res.body
      res
    end
  end
end