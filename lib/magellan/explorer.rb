require 'hpricot'
require 'open-uri'
require 'ostruct'

module Magellan
  class Explorer

    def initialize(urls)
      @urls = urls
    end

    def explore
      reqs = []
      @urls.each do |url|
        reqs.push Thread.new { explore_a(url) }
      end
      reqs.collect { |req| req.value }
    end

    def explore_a(url)
      begin
        response = open(url)
        destination_url = response.base_uri.to_s
        doc = Hpricot(response)
        status_code = response.status.nil? ? "" : response.status.first
        if response.content_type == "text/html"
          Explorer.create_result(url, destination_url, status_code, doc.links_to_other_documents)
        else
          Explorer.create_result(url, destination_url, status_code, [])
        end
      rescue OpenURI::HTTPError => the_error
        Explorer.create_result(url, destination_url, the_error.io.status.first, [])
      end
    end

    def self.create_result(url,destination_url,status_code,links)
      #TODO: not happy with this, handles the error and returns nil and flattens, need to consider how (if) we want to report these errors
      #do we want to pass the bad url back somehow?
      absolute_links = links.map { |linked_resource| linked_resource.to_absolute_url(url) }.compact
      OpenStruct.new({:status_code => status_code, :linked_resources => absolute_links, :url => url, :destination_url => destination_url})
    end
  end
end
