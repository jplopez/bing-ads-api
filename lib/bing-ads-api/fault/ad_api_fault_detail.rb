# -*- encoding : utf-8 -*-

module BingAdsApi
	
	# Public : Defines a fault object that operations return when generic errors occur, 
	# such as an authentication error. 
	# 
	# Author jlopezn@neonline.cl 
	class AdApiFaultDetail < BingAdsApi::ApplicationFault
		
		attr_accessor :errors
		
		
		# Public : Constructor 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# attributes - Hash with the initial attributes
		# === Attributes
		# * tracking_id : the operation tracking id value
		# * errors : array of hashes with the Ad api errors
		def initialize(attributes={})
			super(attributes)
			if attributes
				initialize_errors(attributes[:errors])
			end
		end
		
		# Public : Specified to string method 
		# 
		# Author jlopezn@neonline.cl 
		def to_s
			str = super.to_s + ":\n" 
			if batch_errors
				str += "\tErrors:\n" + errors.map{ |e| "\t" + e.to_s }.join("\n")
			end
			
			return str
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