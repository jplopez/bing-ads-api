# -*- encoding : utf-8 -*-

module BingAdsApi

	class BatchError < BingAdsApi::DataObject
	
		attr_accessor :code, :details, :error_code, :index, :message, :type
		
	end
end 
