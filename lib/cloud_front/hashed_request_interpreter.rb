module CloudFront
  class HashedRequestInterpreter
    def initialize(app)
      @app = app
    end

    def call(env)
      setup_path_info!(env)
      @app.call(env)
    end


    private


    def setup_path_info!(env)
      env['PATH_INFO'].gsub!(%r{^/#{ENV['COMMIT_HASH']}}, '')
    end
  end
end
