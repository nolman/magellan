require 'net/http'

module Magellan
  class Explorer
    def initialize()
    end
    def explore
      
    end    
  end
end

class String
  
end
# 
# proxy_addr = '10.8.77.100'
# proxy_port = 8080
# url = URI.parse('http://www.google.com/')
# req = Net::HTTP::Get.new(url.path)
# res = Net::HTTP::Proxy(proxy_addr, proxy_port).start('www.google.com') {|http|
#   http.request(req)
# }
