# -*- encoding : utf-8 -*-

module BingAdsApi

	class OperationError < BingAdsApi::DataObject
	
		attr_accessor :code, :details, :error_code, :message
		
	end
end 
