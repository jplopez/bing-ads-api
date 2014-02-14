# -*- encoding : utf-8 -*-

module BingAdsApi

	# Public : Defines an error object that contains the details that explain why the service operation failed.
	# 
	# Reference : http://msdn.microsoft.com/en-US/library/bing-ads-overview-adapierror.aspx
	# 
	# Author jlopezn@neonline.cl 
	class AdApiError < BingAdsApi::DataObject
	
		attr_accessor :code, :detail, :error_code, :message
		
	end
end 
