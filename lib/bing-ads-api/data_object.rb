# -*- encoding : utf-8 -*-

module BingAdsApi
	
	##
	# Public : Base Class to define Bing API data objects
	# Do not use this class directly, use any of the derived classes 
	# 
	# Author:: jlopezn@neonline.cl 
	# 
	class DataObject
		
		
		include BingAdsApi::SOAPHasheable
		
		# Public : Constructor in a ActiveRecord style, with a hash of attributes as input 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# attributes - Hash with the objects attributes
		def initialize(attributes={})
			attributes.each { |key, val| send("#{key}=", val) if respond_to?("#{key}=") }
		end
		
		
		# Public : Specified to string method 
		# 
		# Author:: jlopezn@neonline.cl 
		def to_s
			to_hash.to_s
		end


	end
end