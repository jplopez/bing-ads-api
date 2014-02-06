# -*- encoding : utf-8 -*-

module BingAdsApi

	class AdApiError < BingAdsApi::DataObject
	
		attr_accessor :code, :detail, :error_code, :message
		
	end
end 
