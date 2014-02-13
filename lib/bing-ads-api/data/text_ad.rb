# -*- encoding : utf-8 -*-

module BingAdsApi
	
	# Public : Defines a text ad. 
	# 
	# Author jlopezn@neonline.cl 
	# 
	class TextAd < BingAdsApi::Ad
		
		attr_accessor :destination_url,
			:display_url,
			:text,
			:title
	end
end