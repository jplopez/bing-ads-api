# -*- encoding : utf-8 -*-

module BingAdsApi
	
	class Campaign < BingAdsApi::DataObject
		include BingAdsApi::TimeZone
		include BingAdsApi::BudgetLimitType
		include BingAdsApi::CampaignStatus
		include BingAdsApi::PricingModel
		
		
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