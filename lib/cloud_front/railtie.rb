require 'rails/railtie'

module CloudFront
  class Railtie < ::Rails::Railtie
    config.cloud_front = ActiveSupport::OrderedOptions.new

    initializer 'cloud_front.configure' do |app|
      CloudFront.domain = app.config.cloud_front.domain
    end

    initializer 'cloud_front.insert_middleware', :before => 'cloud_front.configure' do |app|
      insert_middleware(app) if enabled?(app)
    end

    initializer 'cloud_front.configure_asset_host', :before => 'cloud_front.insert_middleware' do |app|
      setup_asset_host(app) if enabled?(app)
    end

    initializer 'cloud_front.configure_asset_path', :before => 'cloud_front.configure_asset_host' do |app|
      setup_asset_path(app) if enabled?(app)
    end



    def enabled?(app)
      app.config.cloud_front.domain.present?
    end
    private :enabled?

    def insert_middleware(app)
      app.config.middleware.
        insert_before(ActionDispatch::Static,
                      CloudFront::HashedRequestInterpreter)
    rescue
      app.config.middleware.insert 0, CloudFront::HashedRequestInterpreter
    end
    private :insert_middleware

    def setup_asset_host(app)
      app.config.action_controller.asset_host = lambda do |source, request|
        CloudFront.asset_host(source, request)
      end
    end
    private :setup_asset_host

    def setup_asset_path(app)
      app.config.action_controller.asset_path = lambda do |path|
        CloudFront.asset_path(path)
      end
    end
    private :setup_asset_path
  end
end
