require 'hpricot'
require 'open-uri'
require 'ostruct'

module Magellan
  class Explorer

    def initialize(url)
      @url = url
    end

    def explore
      explore_a(@url)
    end

    def explore_a(url)
      begin
        response = open(url)
        doc = Hpricot(response)
        convert_to_absolute_urls(response.status.first, doc.links_to_other_documents)
      rescue OpenURI::HTTPError => the_error
        convert_to_absolute_urls(the_error.io.status.first, [])
      end
    end

    def convert_to_absolute_urls(status_code,linked_resources)
      absolute_links = linked_resources.map { |linked_resource| linked_resource.to_absolute_url(@url)}
      Explorer.create_result(@url,status_code,absolute_links)
    end

    def self.create_result(url,status_code,absolute_links)
      OpenStruct.new({:status_code => status_code, :linked_resources => absolute_links, :url => url})
    end
  end
end
