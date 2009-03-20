require 'hpricot'
require 'open-uri'

module Magellan
  class Explorer
    def explore(url)
      response = open(url)
      doc = Hpricot(response)
      Result.new(url,"200",doc.links_to_other_documents)
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