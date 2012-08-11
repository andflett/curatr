module Curatr
  module Helpers
    module FormBuilder
      extend ActiveSupport::Concern
      
      def curatr_publish_field(method, options = {})
        @template.send("curatr_publish_field", @object_name, method, objectify_options(options))
      end
    end
  end
end