# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cloud_front/version"

Gem::Specification.new do |s|
  s.name        = "cloud_front"
  s.version     = CloudFront::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nathaniel Bibler"]
  s.email       = ["gem@nathanielbibler.com"]
  s.homepage    = "https://github.com/nbibler/cloud_front"
  s.summary     = %q{A Rack middleware and Rails 3 configuration for using the Amazon CloudFront CDN as a front for your application as a custom origin.}
  s.description = %q{This library sets up your application to use the Amazon CloudFront CDN by modifying your Rails 3 asset_host to the host you specify.  It also allows you to use your Rails 3 application directly as the origin server for CloudFront alleviating the need to upload your resources to Amazon S3.  The included middleware manages recognizing and re-routing CloudFront-based requests to local assets.}

  s.add_dependency 'rails', '~> 3.0.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
