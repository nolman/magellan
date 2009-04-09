module Magellan
  module Rake
    # The base magellan rake task, defines most attributes associated with running a magellan task
    #TODO: this is not a good place to use a template method - violates Liskov substitution principle
    class BaseMagellanTask < ::Rake::TaskLib
      # The url to start the crawl at
      attr_accessor :origin_url
      # How deep to explore
      attr_accessor :explore_depth
      # An array of urls to not crawl
      attr_accessor :ignored_urls
      # The kind of links you would like 
      attr_accessor :links_to_explore
      # The success message for the task, this is set by the broken link and expected links task.
      attr_accessor :success_message
      # If this is set the logger will log out failures to a file that you specify here, you can tail this log
      # while the crawl is running so you can see what is failing
      attr_accessor :failure_log
      
      def initialize(name) # :nodoc:
        @ignored_urls = []
        @name=name
        yield self if block_given?
        define
      end

      def define # :nodoc:
        desc description
        task @name do
          settings = {:origin_url => origin_url, :depth_to_explore => explore_depth, :domains => [origin_url], 
                      :ignored_urls =>ignored_urls, :links_to_explore => links_to_explore, :trace => ENV['TRACE']}
          cartographer = Magellan::Cartographer.new(settings)
          observer = create_observer
          observer.add_observer(Magellan::Logger.new(failure_log))
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
