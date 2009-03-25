require 'rake'
require 'rake/tasklib'
require 'magellan'

module Magellan
  module Rake
    
    #example usage:
    #Magellan::Rake::Task.new do |t|
    #  t.origin_url = "http://localhost:3000/"
    #  t.explore_depth = 100
    #end
    class BrokenLinksTask < ::Rake::TaskLib
      attr_accessor :origin_url
      attr_accessor :explore_depth

      def initialize(name="magellan:explore")
        @name=name
        yield self if block_given?
        define
      end


      def define
        desc "explore #{@origin_url} for broken links"
        task @name do
          cartographer = Magellan::Cartographer.new(@origin_url,@explore_depth)
          broken_link_tracker = Magellan::BrokenLinkTracker.new
          cartographer.add_observer(broken_link_tracker)
          cartographer.crawl
          if broken_link_tracker.has_broken_links?
            STDERR.puts broken_link_tracker.failure_message
            raise "#{@name} failed while exploring"
          end
        end

      end
    end

  end
end
