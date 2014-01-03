# -*- encoding : utf-8 -*-

module BingAdsApi

	# Public : Utility class for TimeZones values
	#
	# Example
	#   BingAdsApi::TimeZone.SANTIAGO
	#   # => 'Santiago'
	# 
	# Author jlopezn@neonline.cl 
	module TimeZone
	
			
		BingAdsApi::Config.instance.common_constants['time_zones'].each do |key, value|
			TimeZone.const_set(key.upcase, value)
		end 
		
	end

	# Public : Utility class for AdLanguages values
	#
	# Example
	#   BingAdsApi::AdLanguages.SPANISH
	#   # => 'Spanish'
	#   BingAdsApi::AdLanguages.SPANISH_CODE
	#   # => 'ES'
	# 
	# Author jlopezn@neonline.cl 
	module AdLanguage
	
		BingAdsApi::Config.instance.common_constants['ad_languages'].each do |key, value|
			if key == 'codes'
				value.each do |code_key, code_value|
					AdLanguage.const_set("#{code_key.upcase}_CODE", code_value)
				end
			else
				AdLanguage.const_set(key.upcase, value)
			end
		end 
		
	end


	## Dynamic classes for campaign management constants
	BingAdsApi::Config.instance.campaign_management_constants.each do |const_key, const_value|

		const_module = Module.new do
			# Dynamically create Constants classes for each value found 
			const_value.each do |key, value|
				self.const_set(key.upcase, value)
			end
	
		end	
		BingAdsApi.const_set(const_key.classify, const_module)

	end


	## Dynamic classes for reporting constants
	BingAdsApi::Config.instance.reporting_constants.each do |const_key, const_value|

		const_class = Class.new(Object) do
			# Dynamically create Constants classes for each value found 
			const_value.each do |key, value|
				self.const_set(key.upcase, value)
			end
	
		end	
		BingAdsApi.const_set(const_key.classify, const_class)

	end

end