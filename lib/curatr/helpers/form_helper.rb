module Curatr
  module Helpers
    module FormHelper

      extend ActiveSupport::Concern
      
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::JavaScriptHelper
      
      def curatr_publish_field(object_name, method, options = {})

        options = { :language => I18n.locale.to_s }.merge(options)
        input_html = (options.delete(:input_html) || {})
        input_html['class'] = "curatr"
        hash = input_html.stringify_keys

        instance_tag = ActionView::Base::InstanceTag.new(object_name, method, self, options.delete(:object))
        instance_tag.send(:add_default_name_and_id, hash)
        
        output_buffer = ActiveSupport::SafeBuffer.new
        output_buffer << instance_tag.to_text_area_tag(input_html)
        
        js_content_for_section = options.delete(:js_content_for)
        js = "new Curatr({ input: $('.curatr') }).init();"

        if js_content_for_section
          content_for(js_content_for_section) { js.html_safe }
        else
          output_buffer << javascript_tag(js)
        end
        
        output_buffer

      end

    end
  end
end