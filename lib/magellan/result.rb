module Magellan
  # The resulting data from crawling a url
  class Result
    # The http status code returned by the request for the specified url
    attr_reader :status_code
    # The original URL requested
    attr_reader :url
    # The destination URL after following redirects
    attr_reader :destination_url
    # Relative linked resources (based off of the kinds of links you are looking for)
    attr_reader :linked_resources
    
    # create a new result, with the status code, url, destination url, linked resources and content type, see attr_readers for more information about these fields
    def initialize(status_code,url,destination_url,linked_resources,content_type) # :nodoc:
      @status_code = status_code
      @url = url
      @destination_url = destination_url
      @linked_resources = linked_resources
      @content_type = content_type
    end
    
    # Absolute links to resources
    def absolute_linked_resources # :nodoc:
      absolute_links = linked_resources.map { |linked_resource| linked_resource.to_s.to_absolute_url(destination_url) }.compact
    end
    
    # Was the document text/html
    def html_content?
      @content_type.starts_with?("text/html")
    end
  end
end
