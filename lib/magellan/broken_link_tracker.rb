module Magellan
  # The class that will track all broken links, urls that return 4** or 5** http status codes.
  class BrokenLinkTracker
    include Observable
    
    # All results containing 4** or 5** http status codes
    attr_reader :broken_links

    # Create a new broken link tracker
    def initialize
      @broken_links = []
      @first_linked_from = {}
    end

    # The updates that come in via a observable subject, the time the result came at and the Magellan::Result itself.
    def update(time,result)
      failed = result.status_code.starts_with?("5") || result.status_code.starts_with?("4")
      @broken_links << result if failed
      changed
      notify_observers(Time.now, !failed, broken_link_message(result))
      result.absolute_linked_resources.each do |linked_resource|
        @first_linked_from[linked_resource] = result.url if !@first_linked_from.has_key?(linked_resource)
      end
    end

    # Are there any broken links?
    def failed? 
      !@broken_links.empty?
    end

    # A text message of all failures
    def failure_message
      @broken_links.map{|broken_link| broken_link_message(broken_link)}.join("\n")
    end
    
    # Generate the failure message for a Magellan::Result
    def broken_link_message(result)
      "#{result.url} first linked from: #{@first_linked_from[result.url]} returned: #{result.status_code}"
    end
  end
end
