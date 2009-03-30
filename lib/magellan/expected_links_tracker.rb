module Magellan
  class ExpectedLinksTracker
    attr_reader :errors
    
    def initialize(expected_patterns)
      @errors = []
      @expected_patterns = expected_patterns
    end
    
    def update(time,result)
      @expected_patterns.each do |pattern,expectation|
        @errors << "#{result.url} did not contain a link to #{expectation}" unless result.linked_resources.include?(expectation)
      end
    end

  end
end
