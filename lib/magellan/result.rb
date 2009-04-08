module Magellan
  class Result
    attr_reader :status_code,:url,:destination_url,:linked_resources
    def initialize(status_code,url,destination_url,linked_resources,content_type) # :nodoc:
      @status_code = status_code
      @url = url
      @destination_url = destination_url
      @linked_resources = linked_resources
      @content_type = content_type
    end
    
    def absolute_linked_resources
      absolute_links = linked_resources.map { |linked_resource| linked_resource.to_s.to_absolute_url(destination_url) }.compact
    end
    
    def html_content?
      @content_type.starts_with?("text/html")
    end
  end
end
