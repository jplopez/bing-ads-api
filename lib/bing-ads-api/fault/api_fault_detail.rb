# -*- encoding : utf-8 -*-

class BingAdsApi::ApiFaultDetail < BingAdsApi::ApplicationFault
	
	attr_accessor :batch_errors, :operation_errors
	
end 
