# -*- encoding : utf-8 -*-

module BingAdsApi

	# Public : Defines the base object from which all fault detail objects derive. 
	# 
	# Reference: http://msdn.microsoft.com/en-US/library/bing-ads-overview-applicationfault.aspx
	#
	# Author:: jlopezn@neonline.cl 
	class ApplicationFault < BingAdsApi::DataObject
		
		attr_accessor :tracking_id
		
		def to_s
			return tracking_id.to_s
		end
	end
end