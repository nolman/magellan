module Magellan
  # The observer that will listen to all results and compare them to a list of rules about expected urls.
  class ExpectedLinksTracker
    include Observable
    # An array of failed expecations
    attr_reader :errors

    # Create a new expected links tracker.
    # An array of tuples of the url pattern and expected link is a required argument.
    # Example:
    # Magellan::ExpectedLinksTracker.new([[/.*/,'/about_us.html']])
    def initialize(expected_patterns)
      @errors = []
      @expected_patterns = expected_patterns
      @evaluated_expectations = {}
    end

    # The updates that come in via a observable subject, the time the result came at and the Magellan::Result itself.
    def update(time,result)
      if result.html_content?
        patterns_that_apply(result).each do |pattern,expectation|
          passed = result.linked_resources.include?(expectation)
          changed
          message = "#{result.url} did not contain a link to #{expectation}"
          notify_observers(Time.now, passed, message)
          @errors << message unless passed
        end
      end
    end

    def patterns_that_apply(result) # :nodoc:
      res = @expected_patterns.select{|pattern,expecation| result.url =~ pattern || result.destination_url =~ pattern}
      res.each { |expected_pattern| @evaluated_expectations[expected_pattern] = nil }
      res
    end

    def has_errors? # :nodoc:
      !@errors.empty?
    end

    def unmet_expecations? # :nodoc:
      !unmet_expecations.empty?
    end

    # Are there expected urls that have not been found yet, or pages that have been found with missing links?
    def failed?
      unmet_expecations? || has_errors?
    end
    
    # A string summary of all failure messages
    def failure_message
      unmet_expecations_messages << errors.join("\n")
    end

    def unmet_expecations_messages # :nodoc:
      message = ""
      unmet_expecations.each {|pattern,unmet_expecation| message << "#{pattern} was never evaluted during the crawl\n"}
      message
    end

    # Expecations that have never been evaluated
    def unmet_expecations
      @expected_patterns - @evaluated_expectations.keys
    end
  end
end
