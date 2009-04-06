
#TODO: this is not a good place to use a template method - violates Liskov substitution principle
module Magellan
  module Rake
    class BaseMagellanTask < ::Rake::TaskLib
      attr_accessor :origin_url
      attr_accessor :explore_depth
      attr_accessor :ignored_urls

      def initialize(name)
        @name=name
        yield self if block_given?
        define
      end

      def define
        desc description
        task @name do
          cartographer = Magellan::Cartographer.new(@origin_url,@explore_depth)
          observer = create_observer
          observer.add_observer(Magellan::Logger.new)
          cartographer.add_observer(observer)
          cartographer.crawl
          if observer.failed?
            STDERR.puts observer.failure_message
            exit 1
          else
            $stdout.puts success_message
          end
        end

      end


    end
  end
end
