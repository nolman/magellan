require 'hpricot'
require 'open-uri'

module Magellan
  class Explorer
    def explore(url)
      begin
        response = open(url)
        doc = Hpricot(response)
        Result.new(url,response.status.first,doc.links_to_other_documents)
      rescue OpenURI::HTTPError => the_error
        Result.new(url,the_error.io.status.first,[])
      end
    end
  end
end
