# -*- encoding : utf-8 -*-

require 'savon'
require 'bing-ads-api/config'
require 'bing-ads-api/service'
require 'bing-ads-api/client_proxy'
require 'bing-ads-api/data_object'

require 'bing-ads-api/constants'

# Require services
Dir[File.join(File.dirname(__FILE__), 'bing-ads-api', 'service', '*.rb')].each { |file| require file }

# Require data objects
Dir[File.join(File.dirname(__FILE__), 'bing-ads-api', 'data', '*.rb')].each { |file| require file }

module BingAdsApi
	

end
