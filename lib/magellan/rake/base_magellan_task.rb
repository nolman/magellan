
#TODO: this is not a good place to use a template method - violates Liskov substitution principle
module Magellan
  module Rake
    class BaseMagellanTask < ::Rake::TaskLib
      attr_accessor :origin_url
      attr_accessor :explore_depth
      attr_accessor :ignored_urls
      attr_accessor :links_to_explore
      attr_accessor :success_message
      
      def initialize(name)
        @ignored_urls = []
        @name=name
        yield self if block_given?
        define
      end

      def define
        desc description
        task @name do
          settings = {:origin_url => origin_url, :depth_to_explore => explore_depth, :domains => [origin_url], 
                      :ignored_urls =>ignored_urls, :links_to_explore => links_to_explore, :trace => ENV['TRACE']}
          cartographer = Magellan::Cartographer.new(settings)
          observer = create_observer
          observer.add_observer(Magellan::Logger.new)
          cartographer.add_observer(observer)
          cartographer.crawl
          if observer.failed?
            STDERR.puts "\n" + observer.failure_message
            exit 1
          else
            $stdout.puts "\n" + success_message
          end
        end

      end


    end
  end
end
