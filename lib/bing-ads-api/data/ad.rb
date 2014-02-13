# -*- encoding : utf-8 -*-

module BingAdsApi
	
	# Public : Defines the base object of an ad. 
	#   Do not instantiate this object. Instead you can instantiate the 
	#   BingAdsApi::TextAd, BingAdsApi::MobileAd, or BingAdsApi::ProductAd 
	#   object that derives from this object.
	# 
	# Author jlopezn@neonline.cl 
	# 
	class Ad < BingAdsApi::DataObject
		include BingAdsApi::AdEditorialStatus
		include BingAdsApi::AdStatus
		include BingAdsApi::AdType
		
		
		attr_accessor :id,

			:device_preference,
			:editorial_status,

			:status,
			:type
			
	end

	# Public : Defines a text ad. 
	# 
	# Author jlopezn@neonline.cl 
	# 
	class TextAd < BingAdsApi::Ad
		
		attr_accessor :destination_url,
			:display_url,
			:text,
			:title
			
		def to_hash(keys = :underscore)
			hash = super(keys)
			hash[get_attribute_key("type", keys)] = "Text"
			return hash
		end
	end
	
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

		def to_hash(keys = :underscore)
			hash = super(keys)
			hash[get_attribute_key("type", keys)] = "Mobile"
			return hash
		end

	end
	
	# Public : Defines a product ad.
	# 
	# Author jlopezn@neonline.cl 
	# 
	class ProductAd < BingAdsApi::Ad
		
		attr_accessor :promotional_text
	
		def to_hash(keys = :underscore)
			hash = super(keys)
			hash[get_attribute_key("type", keys)] = "Product"
			return hash
		end

	end
	
end