require 'rake'
require 'rake/tasklib'
require 'magellan'

module Magellan
  module Rake
    class ExpectedLinksTask < ::Rake::TaskLib
      attr_accessor :origin_url
      attr_accessor :explore_depth
      attr_accessor :patterns_and_expected_links

      def initialize(name="magellan:check_links")
        @name = name
        yield self if block_given?
        define
      end

      def define
        task @name do
          cartographer = Magellan::Cartographer.new(@origin_url,@explore_depth)
          expected_link_tracker = Magellan::ExpectedLinksTracker.new([])
          cartographer.add_observer(expected_link_tracker)
          cartographer.crawl
        end
      end
    end

  end
end
