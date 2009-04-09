require 'rake'
require 'rake/tasklib'
require 'magellan'
require 'magellan/rake/base_magellan_task'

module Magellan
  module Rake
    # Example:
    # Magellan::Rake::ExpectedLinksTask.new("digg") do |t|
    #   t.origin_url = "http://digg.com/"
    #   t.explore_depth = 2
    #   t.patterns_and_expected_links = YAML.load_file("digg.yml")
    # end
    class ExpectedLinksTask < BaseMagellanTask
      # Tuple of patterns and expected links at a given pattern
      # Example:
      # patterns_and_expected_links = [[/.*/,'/about_us.html']] # => this says all pages should have a link to the about us page.
      attr_accessor :patterns_and_expected_links

      # Defines a new task, using the name +name+.
      def initialize(name="magellan:check_links")
        @success_message = "All expected links found!"
        @links_to_explore = [["a","href"]]
        super(name)
      end

      def description # :nodoc:
        "Explore #{@origin_url} and find check if all given patterns are matched"
      end

      def create_observer # :nodoc:
        Magellan::ExpectedLinksTracker.new(@patterns_and_expected_links)
      end
    end

  end
end
