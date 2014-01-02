# -*- encoding : utf-8 -*-

module BingAdsApi
	
	class Campaign < BingAdsApi::DataObject
		include BingAdsApi::CommonConstants
		include BingAdsApi::CampaignManagementConstants
		
		attr_accessor :budget_type, 
			:conversion_tracking_enabled,
			:daily_budget,
			:daylight_saving,
			:description,
			:monthly_budget,
			:name,
			:status,
			:time_zone
		
	end
end