# -*- encoding : utf-8 -*-

module BingAdsApi

	# Public : Defines an error object that contains the details that explain why the service operation failed.
	# 
	# Author:: jlopezn@neonline.cl
	# 
	# Reference : http://msdn.microsoft.com/en-US/library/bing-ads-overview-operationerror.aspx
	class OperationError < BingAdsApi::DataObject
	
		attr_accessor :code, :details, :error_code, :message
		
		
		# Public : Specified to string method 
		# 
		# Author:: jlopezn@neonline.cl 
		def to_s
			"#{code}:#{error_code} - #{message}. #{details}"
		end
	end
end 
