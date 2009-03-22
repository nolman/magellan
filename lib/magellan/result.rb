module Magellan
  class Result
    attr_reader :status_code, :linked_resources, :url
    attr_accessor :origin_url
    def initialize(url,status_code, linked_resources)
      @url = url
      @status_code = status_code
      @linked_resources = linked_resources.map { |linked_resource| linked_resource.to_absolute_url(url)}
    end
    def to_s
      "#{url} was linked from: #{origin_url} responded with: #{status_code}"
    end
  end
end