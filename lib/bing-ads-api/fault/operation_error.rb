# -*- encoding : utf-8 -*-

module BingAdsApi

	class OperationError < BingAdsApi::DataObject
	
		attr_accessor :code, :details, :error_code, :message
		
		def to_s
			"#{code}:#{error_code} - #{message}. #{details}"
		end
	end
end 
