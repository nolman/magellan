require 'hpricot'
require 'open-uri'
require 'ostruct'

module Magellan
  class Explorer

    def initialize(url)
      @url = url
    end

    def explore
      doit(@url)
    end

    def doit(url)
      begin
        response = open(@url)
        doc = Hpricot(response)
        convert_to_absolute_urls(response.status.first, doc.links_to_other_documents)
      rescue OpenURI::HTTPError => the_error
        convert_to_absolute_urls(the_error.io.status.first, [])
      end
    end

    def convert_to_absolute_urls(status_code,linked_resources)
      absolute_links = linked_resources.map { |linked_resource| linked_resource.to_absolute_url(@url)}
      OpenStruct.new({:status_code => status_code, :linked_resources => absolute_links, :origin_url => @url})
    end
  end
end
