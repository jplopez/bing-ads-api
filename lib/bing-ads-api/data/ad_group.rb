# -*- encoding : utf-8 -*-

module BingAdsApi
	
	class AdGroup < BingAdsApi::DataObject
		include BingAdsApi::AdDistribution
		include BingAdsApi::AdRotationType
		include BingAdsApi::PricingModel
		include BingAdsApi::BiddingModel
		include BingAdsApi::AdLanguage
		include BingAdsApi::AdGroupStatus
		
		
		attr_accessor :id,
			:ad_distribution,
			:ad_rotation,

			:broadmatch_bid,
			:content_match_bid,
			:exact_match_bid,
			:phrase_match_bid,

			:bidding_model, 
			:pricing_model,

			:language,
			:name,
			:status,

			:start_date,
			:end_date
			
			
		
	end
end