require 'rails/generators'

module Curatr
  module Generators
    class ExtensionGenerator < Rails::Generators::NamedBase

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def extension

        puts "Generating Curatr extension for #{name}"

        @model = name.classify
        @filename = name.underscore
        
        if File.exist?('config/curatr.yml')
          append_file 'config/curatr.yml', "\nsomethinghere"
        else
          template "_config.yml", "config/curatr.yml"
        end
                
        template "_initializer.rb", "config/initializers/curatr/#{@filename}.rb"
                
      end

    end
  end
end