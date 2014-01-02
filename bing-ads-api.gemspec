$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bing-ads-api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
	s.name        = "bing-ads-api"
	s.version     = BingAdsApi::VERSION
	s.authors     = ["Juan Pablo Lopez N"]
	s.email       = ["jp.lopez.navarro@gmail.cl"]
	s.homepage    = "http://www.github.com/jplopez/bing-ads-api"
	s.summary     = "Bing Ads API for Rails"
	s.description = "A set of pure RoR classes for the Bing Ads API"

	s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
	s.test_files = Dir["test/**/*"]

	s.add_dependency "rails"
	s.add_dependency "savon", "~> 2.3.0"

	s.add_development_dependency "sqlite3"
end
