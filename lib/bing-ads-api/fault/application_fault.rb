# -*- encoding : utf-8 -*-

module BingAdsApi

	class ApplicationFault < BingAdsApi::DataObject
		
		attr_accessor :tracking_id
		
		def to_s
			return tracking_id.to_s
		end
	end
end