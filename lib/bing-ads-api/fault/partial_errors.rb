# -*- encoding : utf-8 -*-

module BingAdsApi
	
	# Public : Defines an array of error that occur when adding ads  
	# 
	# Author jlopezn@neonline.cl 
	class PartialErrors < BingAdsApi::DataObject
		
		attr_accessor :batch_errors
		
		
		# Public : Constructor 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# attributes - Hash with the initial attributes
		# === Attributes
		# * tracking_id : the operation tracking id value
		# * batch_error : array of hashes with the batch errors
		def initialize(attributes={})
			super(attributes)
			if attributes
				initialize_batch_errors(attributes)
			end
		end
		
		
		# Public : Specified to string method 
		# 
		# Author jlopezn@neonline.cl 
		def to_s
			str = "  Batch Errors:\n"
			if batch_errors
				str += batch_errors.map{ |be| "\t" + be.to_s }.join("\n")
			end
			
			return str
		end
		
		
		private
		
			# Public : Helper method for the ApiFaultDetail constructor 
			#   to initialize the batch errors array 
			# 
			# Author jlopezn@neonline.cl 
			# 
			# batch_errors_hash - Hash with the :batch_errors key received from the SOAP request
			# 
			# Returns none
			def initialize_batch_errors(batch_errors_hash)
				return if batch_errors_hash.nil?
				
				if batch_errors_hash[:batch_error].is_a?(Array)
					self.batch_errors = []
					batch_errors_hash[:batch_error].each do |be|
						self.batch_errors << init_batch_error(be)
					end
				elsif batch_errors_hash[:batch_error].is_a?(Hash)
					self.batch_errors = [ init_batch_error(batch_errors_hash[:batch_error]) ]
				end
			end
			
			
			def init_batch_error(batch_error_hash)
				if batch_error_hash.key?("@i:type".to_sym) && batch_error_hash["@i:type".to_sym] == "EditorialError"
					return BingAdsApi::EditorialError.new(batch_error_hash)
				else
					return BingAdsApi::BatchError.new(batch_error_hash)
				end
			end
	end
	
end