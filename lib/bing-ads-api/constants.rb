# -*- encoding : utf-8 -*-

module BingAdsApi
	
	module CommonConstants
		class <<self
			BingAdsApi::Config.instance.common_constants.each do |key, value|
			
				define_method("#{key.upcase}") do |constant=nil|
					value[constant] if constant
					value
				end
			
			end
		end
	end


	module CampaignManagementConstants
		class <<self
			BingAdsApi::Config.instance.campaign_management_constants.each do |key, value|
			
				define_method("#{key.upcase}") do |constant=nil|
					value[constant.to_s] if constant
					value
				end
			
			end
		end
	end

end