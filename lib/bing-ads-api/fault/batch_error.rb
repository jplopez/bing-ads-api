# -*- encoding : utf-8 -*-

module BingAdsApi

	class BatchError < BingAdsApi::DataObject
	
		attr_accessor :code, :details, :error_code, :index, :message, :type
		
		def to_s
			"#{index}:#{code}:#{error_code} - #{message} (#{type})"
		end
	end
end 
