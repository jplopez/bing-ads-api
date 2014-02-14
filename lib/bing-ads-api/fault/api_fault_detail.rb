# -*- encoding : utf-8 -*-

module BingAdsApi
	
	# Public : Defines a fault object that operations return when web service-specific errors occur, 
	# such as when the request message contains incomplete or invalid data. 
	# 
	# Author jlopezn@neonline.cl 
	class ApiFaultDetail < BingAdsApi::ApplicationFault
		
		attr_accessor :batch_errors, :operation_errors
		
		
		# Public : Constructor 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# attributes - Hash with the initial attributes
		# === Attributes
		# * tracking_id : the operation tracking id value
		# * batch_errors : array of hashes with the batch errors
		# * operation_errors : array of hashes with the operation errors 
		def initialize(attributes={})
			super(attributes)
			if attributes
				initialize_batch_errors(attributes[:batch_errors])
				initialize_operations_errors(attributes[:operation_errors])
			end
		end
		
		
		# Public : Specific to string  
		# 
		# Author jlopezn@neonline.cl 
		# 
		# Returns the object 'stringified'
		def to_s
			str = super.to_s + ":\n" 
			if batch_errors
				str += "\tBatch Errors:\n" + batch_errors.map{ |be| "\t" + be.to_s }.join("\n")
			end
			
			if operation_errors
				str += "\tOperation Errors:\n" + operation_errors.map{ |oe| "\t" + oe.to_s }.join("\n")
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