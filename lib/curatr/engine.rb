module Curatr

  class Engine < Rails::Engine

    initializer "curatr.load_app_instance_data" do |app|
      Curatr.setup do |config|
        config.app_root = app.root
      end
    end

    initializer "curatr.load_static_assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    initializer "curatr.helpers" do
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, Curatr::Helpers::FormHelper
        ActionView::Helpers::FormBuilder.send :include, Curatr::Helpers::FormBuilder
      end
    end

  end
  
  def self.config(&block)
    @@config ||= Curatr::Engine::Configuration.new
    yield @@config if block
    return @@config
  end

end