require 'cloud_front/railtie' if defined?(::Rails::Railtie)

module CloudFront
  autoload :HashedRequestInterpreter, 'cloud_front/hashed_request_interpreter'

  mattr_accessor :domain

  def self.asset_host(source, request)
    if source =~ %r{^//}
      ''
    else
      "#{request.protocol}#{domain}"
    end
  end

  def self.asset_path(asset_path)
    absolute_path = File.join(ActionController::Base.config.assets_dir, asset_path)
    if asset_path.to_s !~ %r{^//} && (File.exist?(absolute_path) || asset_path.to_s =~ /_packaged\.(?:css|js)$/)
      relative_path = Pathname.new(asset_path)
      "/%s%s/%s%s" % [ENV['COMMIT_HASH'], relative_path.dirname, relative_path.basename(relative_path.extname), relative_path.extname.to_s]
    else
      asset_path
    end
  end
end
