# -*- encoding : utf-8 -*-

module BingAdsApi
	
	class ApiFaultDetail < BingAdsApi::ApplicationFault
		
		attr_accessor :batch_errors, :operation_errors
		
		
		def initialize(attributes={})
			super(attributes)
			if attributes
				initialize_batch_errors(attributes[:batch_errors])
				initialize_operations_errors(attributes[:operation_errors])
			end
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
						self.batch_errors << BingAdsApi::BatchError.new(be)
					end
				elsif batch_errors_hash[:batch_error].is_a?(Hash)
					self.batch_errors = [BingAdsApi::BatchError.new(batch_errors_hash[:batch_error])]
				end
			end
			
			
			# Public : Helper method for the ApiFaultDetail constructor 
			#   to initialize the operation errors array 
			# 
			# Author jlopezn@neonline.cl 
			# 
			# operation_errors_hash - Hash with the :operation_errors key received from the SOAP request
			# 
			# Returns none
			def initialize_operations_errors(operation_errors_hash)
				return if operation_errors_hash.nil?
				
				if operation_errors_hash[:operations_error].is_a?(Array)
					self.operation_errors = []
					operation_errors_hash[:operation_error].each do |oe|
						self.operation_errors << BingAdsApi::OperationError.new(oe)
					end
				elsif operation_errors_hash[:operation_error].is_a?(Hash)
					self.operation_errors = [BingAdsApi::OperationError.new(operation_errors_hash[:operation_error])]
				end
				
			end
	end
	
end