module Magellan
  class Result
    attr_reader :status_code, :linked_resources
    def initialize(origin_url,status_code, linked_resources)
      @status_code = status_code
      @linked_resources = linked_resources.map { |linked_resource| linked_resource.to_absolute_url(origin_url)}
    end    
  end
end