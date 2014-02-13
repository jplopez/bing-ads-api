# -*- encoding : utf-8 -*-

module BingAdsApi
	
	# Public : Defines a product ad.
	# 
	# Author jlopezn@neonline.cl 
	# 
	class ProductAd < BingAdsApi::Ad
		
		attr_accessor :promotional_text
	end
end