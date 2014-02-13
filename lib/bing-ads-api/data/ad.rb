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

		# # Public : Constructor in a ActiveRecord style, with a hash of attributes as input 
		# # 
		# # Author jlopezn@neonline.cl 
		# # 
		# # attributes - Hash with the objects attributes
		# def initialize(attributes={})
			# super(attributes)
			# set_custom_attributes(attributes)
		# end
		
		
		# Public : Returns this object as a hash to SOAP requests 
		#    This methods is a specialization for the DataObject#to_hash method
		#    it only ads specific hash keys for the AdGroup object
		# 
		# Author jlopezn@neonline.cl 
		# 
		# keys - specifies the keys case: CamelCase or underscore_case
		# 
		# Returns Hash
		def to_hash(keys = :underscore)
			hash = super(keys)
			
			amount_key = get_attribute_key("amount", keys)
			if self.content_match_bid
				#hash.delete(:content_match_bid)
				hash[get_attribute_key("content_match_bid", keys)] = {amount_key => self.content_match_bid}
			end 
			
			if self.exact_match_bid
				hash[get_attribute_key("exact_match_bid", keys)] = {amount_key => self.exact_match_bid}
			end
			
			if self.phrase_match_bid
				hash[get_attribute_key("phrase_match_bid", keys)] = {amount_key => self.phrase_match_bid}
			end
			
			if self.broad_match_bid
				hash[get_attribute_key("broad_match_bid", keys)] = {amount_key => self.broad_match_bid}
			end
			
			if self.start_date
				hash[get_attribute_key("start_date", keys)] = date_to_hash(self.start_date, keys)
			end
			
			if self.end_date
				hash[get_attribute_key("end_date", keys)] = date_to_hash(self.end_date, keys)
			end
			
			return hash
		end
		
		
		private
			def set_custom_attributes(attributes)
				self.content_match_bid = attributes[:content_match_bid][:amount] if attributes.key?(:content_match_bid) 
				self.exact_match_bid = attributes[:exact_match_bid][:amount] if attributes.key?(:exact_match_bid) 
				self.phrase_match_bid = attributes[:phrase_match_bid][:amount] if attributes.key?(:phrase_match_bid) 
				self.broad_match_bid = attributes[:broad_match_bid][:amount] if attributes.key?(:broad_match_bid) 
				
				if attributes.key?(:start_date) && !attributes[:start_date].nil?
					self.start_date = DateTime.strptime( 
						"#{attributes[:start_date][:year]}-#{attributes[:start_date][:month]}-#{attributes[:start_date][:day]}",
						"%Y-%m-%d")
				end

				if attributes.key?(:end_date) && !attributes[:end_date].nil?
					self.end_date = DateTime.strptime( 
						"#{attributes[:end_date][:year]}-#{attributes[:end_date][:month]}-#{attributes[:end_date][:day]}",
						"%Y-%m-%d")
				end
				
			end
	end
end