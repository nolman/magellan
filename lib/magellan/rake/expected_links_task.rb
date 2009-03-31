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
        define
      end

      def define
        task @name do
          
        end
      end
    end

  end
end
