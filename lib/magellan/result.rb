module Magellan
  class Result
    attr_reader :status_code, :linked_resources
    def initialize(status_code, linked_resources)
      @status_code = status_code
      @linked_resources = linked_resources
    end
  end
end