module Magellan
  class BrokenLinkTracker
    include Observable
    
    attr_reader :broken_links

    def initialize
      @broken_links = []
      @first_linked_from = {}
    end

    def update(time,result)
      failed = result.status_code.starts_with?("5") || result.status_code.starts_with?("4")
      @broken_links << result if failed
      changed
      notify_observers(Time.now, !failed)
      result.absolute_linked_resources.each do |linked_resource|
        @first_linked_from[linked_resource] = result.url if !@first_linked_from.has_key?(linked_resource)
      end
    end

    def has_broken_links?
      !@broken_links.empty?
    end

    def failure_message
      @broken_links.map{|broken_link| "#{broken_link.url} first linked from: #{@first_linked_from[broken_link.url]} returned: #{broken_link.status_code}"}.join("\n")
    end
  end
end
