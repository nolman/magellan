require 'rake'
require 'rake/tasklib'
require 'magellan'
require 'magellan/rake/base_magellan_task'

module Magellan
  module Rake

    class ExpectedLinksTask < BaseMagellanTask
      attr_accessor :patterns_and_expected_links

      def initialize(name="magellan:check_links")
        @success_message = "All expected links found!"
        @links_to_explore = [["a","href"]]
        super(name)
      end

      def description
        "Explore #{@origin_url} and find check if all given patterns are matched"
      end

      def create_observer
        Magellan::ExpectedLinksTracker.new(@patterns_and_expected_links)
      end
    end

  end
end
