require 'hpricot'
require 'open-uri'

module Magellan
  class Explorer
    def explore(url)
      response = open(url)
      doc = Hpricot(response)
      Result.new(url,"200",doc.links_to_other_documents)
    end
  end
end