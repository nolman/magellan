require 'rake'
require 'rake/tasklib'
require 'magellan'

module Magellan
  module Rake
    class ExpectedLinksTask < ::Rake::TaskLib
      attr_accessor :origin_url
      attr_accessor :explore_depth
      attr_accessor :patterns_and_expected_links
      attr_accessor :ignored_urls
      
      def initialize(name="magellan:check_links")
        @name = name
        @ignored_urls = []
        yield self if block_given?
        define
      end

      def define
        desc "Explore a site and find check if all given patterns are matched"
        task @name do
          cartographer = Magellan::Cartographer.new(@origin_url,@explore_depth,@origin_url,@ignored_urls)
          expected_link_tracker = Magellan::ExpectedLinksTracker.new(@patterns_and_expected_links)
          cartographer.add_observer(expected_link_tracker)
          cartographer.crawl
          if expected_link_tracker.failed?
            STDERR.puts expected_link_tracker.failure_message
            exit 1
          end
        end
      end
    end

  end
end
