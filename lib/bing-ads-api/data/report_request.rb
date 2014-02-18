# -*- encoding : utf-8 -*-

module BingAdsApi
	
	##
	# Public : Defines the base object for all report requests.
	# Do not instantiate this object. Instead, you may instantiate one 
	# of the following report request objects which derives from this object to request a report.
	# 
	# Reference: http://msdn.microsoft.com/en-us/library/bing-ads-reporting-bing-ads-reportrequest.aspx
	# 
	# Author jlopezn@neonline.cl 
	class ReportRequest < BingAdsApi::DataObject
		
		# Valid Formats for reports 
		FORMATS = BingAdsApi::Config.instance.
			reporting_constants['format']
		
		# Valid languages for reports 
		LANGUAGES = BingAdsApi::Config.instance.
			reporting_constants['language']

		# Valid languages for reports 
		TIME_PERIODS = BingAdsApi::Config.instance.
			reporting_constants['time_periods']

		# Valid report request status for reports 
		REQUEST_STATUS = BingAdsApi::Config.instance.
			reporting_constants['request_status_type']
		
		attr_accessor :format, :language, :report_name, :return_only_complete_data
		
		# Public : Constructor. Adds validations to format and language attributes 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# === Parameters
		# attributes - Hash with Report request parameters
		def initialize(attributes={})
			raise Exception.new("Invalid format '#{attributes[:format]}'") if !valid_format(attributes[:format])
			raise Exception.new("Invalid language '#{attributes[:language]}'") if !valid_language(attributes[:language])
			super(attributes)
		end
	
	
		private
		
			def valid_format(format)
				return FORMATS.key?(format.to_s)
			end
			
			
			def valid_language(language)
				return LANGUAGES.key?(language.to_s)
			end
			
			
			def valid_time(time)
				# Custom date range
				if time.is_a?(Hash)
					return false if !time.key?(:custom_date_range_start)
					return false if !time.key?(:custom_date_range_end)
				# Time periods
				else
					return TIME_PERIODS.key?(time.to_s)
				end
			end
	end
	
end