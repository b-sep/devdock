# frozen_string_literal: true

require 'thor/group'

module SetDevEnv
  module Setup::Generator
    class Base < Thor::Group
      include Thor::Actions

      def self.source_root = "#{File.dirname(__FILE__, 4)}/templates"
    end
  end
end
