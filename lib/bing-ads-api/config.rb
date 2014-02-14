# -*- encoding : utf-8 -*-
require 'singleton'

module BingAdsApi 

	# Public : Helper class for configuration issues like WSDL URLs and constants 
	# 
	# Author author@neonline.cl 
	# 
	# Examples 
	#   class_usage 
	#   # => class_usage_return 
	class Config
		include Singleton
		
		# Array with Bing Ads API environments: +sandbox+ and +production+
		ENVIRONMENTS = ['sandbox', 'production']
		
		attr_accessor :config
		@config = YAML.load_file(File.join(File.dirname(__FILE__),"../bing-ads-api.yml"))
		
		# Public : Constructor 
		# 
		# Author jlopezn@neonline.cl 
		def initialize
			@config = YAML.load_file(File.join(File.dirname(__FILE__),"../bing-ads-api.yml"))
		end

		# Public : Returns the config file as an Hash instance 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# Returns Hash
		def self.hash_instance
			instance.config
		end
		
		## Constants
		@config['constants'].each do |key, value|
			
			define_method("#{key.to_s}_constants") do |constant=nil|
				value[constant.to_s] if constant
				value
			end
			 
		end
		

		# Public : Returns a String with WSDL url for the service indicated 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# === Parameters
		# environment - Bing Environment: 'sandbox' or 'production'
		# service - service name
		# 
		# === Examples 
		#   config.service_wsdl(:sandbox, :campaign_management) 
		#   # => "https://api.sandbox.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v9/CampaignManagementService.svc?singleWsdl"
		# 
		# Returns returns
		# Raises exception
		def service_wsdl(environment, service)
			if (ENVIRONMENTS.include?(environment.to_s))
				if @config['wsdl'][environment.to_s].include?(service.to_s)
					return @config['wsdl'][environment.to_s][service.to_s]
				end
				raise "Unknown service '#{service.to_s}'. Available services: #{@config['wsdl'][environment.to_s].keys.join(", ")}"
			end
			raise "Invalid environment: #{environment}. Value should be 'sandbox' or 'production'"
		end
 
	end

end	
