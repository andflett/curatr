require 'rails/generators'
require 'rails/generators/migration'

module Curatr
  module Generators
    class ExtensionGenerator < Rails::Generators::NamedBase

      include Rails::Generators::Migration
      
      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end
      
      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.new.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
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
        migration_template '_migration.rb', "db/migrate/add_published_to_#{@filename}.rb"
              
      end

    end
  end
end