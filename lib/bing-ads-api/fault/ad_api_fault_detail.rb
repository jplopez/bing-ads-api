# -*- encoding : utf-8 -*-

module BingAdsApi
	
	class AdApiFaultDetail < BingAdsApi::ApplicationFault
		
		attr_accessor :errors
		
		
		def initialize(attributes={})
			super(attributes)
			if attributes
				initialize_errors(attributes[:errors])
			end
		end
		
		
		private
		
			# Public : Helper method for the AdApiFaultDetail constructor 
			#   to initialize the errors array 
			# 
			# Author jlopezn@neonline.cl 
			# 
			# errors_hash - Hash with the :errors key received from the SOAP request
			# 
			# Returns none
			def initialize_errors(errors_hash)
				return if errors_hash.nil?
				
				if errors_hash[:ad_api_error].is_a?(Array)
					self.errors = []
					errors_hash[:ad_api_error].each do |aae|
						self.errors << BingAdsApi::AdApiError.new(aae)
					end
				elsif errors_hash[:ad_api_error].is_a?(Hash)
					self.errors = [BingAdsApi::AdApiError.new(errors_hash[:ad_api_error])]
				end
			end
			
	end
	
end