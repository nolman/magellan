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
        status_code = response.status.first
        if response.content_type == "text/html"
          Explorer.create_result(url,status_code, doc.links_to_other_documents.map { |linked_resource| linked_resource.to_absolute_url(url)})
        else
          Explorer.create_result(url,status_code, [])
        end
      rescue OpenURI::HTTPError => the_error
        Explorer.create_result(url,the_error.io.status.first, [])
      end
    end

    def self.create_result(url,status_code,absolute_links)
      OpenStruct.new({:status_code => status_code, :linked_resources => absolute_links, :url => url})
    end
  end
end
