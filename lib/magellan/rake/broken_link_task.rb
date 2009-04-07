require 'rake'
require 'rake/tasklib'
require 'magellan'
require 'magellan/rake/base_magellan_task'

module Magellan
  module Rake
    
    class BrokenLinkTask < BaseMagellanTask
      def initialize(name="magellan:explore")
        @links_to_explore = [["a","href"],["script","src"],["img","src"]]
        @success_message = "No broken links were found!"
        super(name)
      end
      
      def create_observer
        Magellan::BrokenLinkTracker.new
      end
      
      def description
        "explore #{@origin_url} for broken links"
      end      
    end
    
  end
end
