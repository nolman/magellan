require 'rake'
require 'rake/tasklib'
require 'magellan'
require 'magellan/rake/base_magellan_task'

module Magellan
  module Rake
    # Example:
    # require 'magellan/rake/broken_link_task'
    # Magellan::Rake::BrokenLinkTask.new("digg") do |t|
    #   t.origin_url = "http://digg.com/"
    #   t.explore_depth = 3
    # end
    class BrokenLinkTask < BaseMagellanTask

      # Defines a new task, using the name +name+.
      def initialize(name="magellan:explore")
        @links_to_explore = [["a","href"],["script","src"],["img","src"]]
        @success_message = "No broken links were found!"
        super(name)
      end
      
      def create_observer # :nodoc:
        Magellan::BrokenLinkTracker.new
      end
      
      def description # :nodoc:
        "explore #{@origin_url} for broken links"
      end      
    end
    
  end
end
