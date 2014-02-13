# -*- encoding : utf-8 -*-

module BingAdsApi
	
	# Public : Defines a mobile ad. A mobile ad is displayed to a user 
	#   when the ad is viewed on a low-fi mobile device.
	# 
	# Author jlopezn@neonline.cl 
	# 
	class MobileAd < BingAdsApi::Ad
		
		attr_accessor :business_name,
			:destination_url,
			:display_url,
			:phone_number,
			:text,
			:title
	end
end