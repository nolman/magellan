module Magellan
  class ExpectedLinksTracker
    attr_reader :errors
    
    def initialize(expected_patterns)
      @errors = []
      @expected_patterns = expected_patterns
    end
    
    def update(time,result)
      patterns_that_apply(result).each do |pattern,expectation|
        @errors << "#{result.url} did not contain a link to #{expectation}" unless result.linked_resources.include?(expectation)
      end
    end
    
    def patterns_that_apply(result)
      @expected_patterns.select{|pattern,expecation| result.url =~ pattern || result.destination_url =~ pattern}
    end

    def has_errors?
      !@errors.empty?
    end
  end
end
