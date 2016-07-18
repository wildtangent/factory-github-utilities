module FactoryGithubUtilities
  # Logging extension module
  module Loggable
    def self.included(base)
      base.include(InstanceMethods)
    end

    # Log method
    module InstanceMethods
      private

      def log(message)
        puts message if @debug
      end
    end
  end
end
