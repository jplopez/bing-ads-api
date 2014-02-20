# -*- encoding : utf-8 -*-

module BingAdsApi

	# Public : Utility class for TimeZones values
	#
	# Example
	#   BingAdsApi::TimeZone.SANTIAGO
	#   # => 'Santiago'
	# 
	# Author:: jlopezn@neonline.cl 
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
	# Author:: jlopezn@neonline.cl 
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
		BingAdsApi.const_set(const_key.camelize, const_module)

	end

	# Public : Module for Reporting formats 
	# 
	# Example
	#   BingAdsApi::ReportFormat.CSV
	#   # => 'Csv'
	#
	# Author:: jlopezn@neonline.cl 
	module ReportFormat
		BingAdsApi::Config.instance.reporting_constants['format'].each do |key, value|
			ReportFormat.const_set(key.upcase, value)
		end
	end
	
	
	# Public : Module for Reporting languages 
	# 
	# Example
	#   BingAdsApi::ReportLanguage.ENGLISH
	#   # => 'English'
	#
	# Author:: jlopezn@neonline.cl 
	module ReportLanguage
		BingAdsApi::Config.instance.reporting_constants['language'].each do |key, value|
			ReportLanguage.const_set(key.upcase, value)
		end
	end
	
	
	# Public : Module for Reporting languages 
	# 
	# Example
	#   BingAdsApi::ReportAggregation.SUMMARY
	#   # => 'Summary'
	#   BingAdsApi::ReportAggregation.HOURLY
	#   # => 'Hourly'
	#
	# Author:: jlopezn@neonline.cl 
	module ReportAggregation
		BingAdsApi::Config.instance.reporting_constants['aggregation'].each do |key, value|
			ReportAggregation.const_set(key.upcase, value)
		end
	end
	
	
	# Public : Module for Reporting languages 
	# 
	# Example
	#   BingAdsApi::ReportTimePeriods.TODAY
	#   # => 'Today'
	#   BingAdsApi::ReportTimePeriods.LAST_WEEK
	#   # => 'LastWeek'
	# 
	# Author:: jlopezn@neonline.cl 
	module ReportTimePeriods
		BingAdsApi::Config.instance.reporting_constants['time_periods'].each do |key, value|
			ReportTimePeriods.const_set(key.upcase, value)
		end
	end
	
	
	## Dynamic classes for reporting constants
	# BingAdsApi::Config.instance.reporting_constants.each do |const_key, const_value|
# 
		# const_module = Module.new do
			# # Dynamically create Constants classes for each value found 
			# const_value.each do |key, value|
				# self.const_set(key.upcase, value)
			# end
# 	
		# end	
		# BingAdsApi.const_set(const_key.camelize, const_module)
# 
	# end

end