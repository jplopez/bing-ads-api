# -*- encoding : utf-8 -*-

module BingAdsApi::Helpers
	
	##
	# Public : Utility module 
	# 
	# Author:: jlopezn@neonline.cl 
	# 
	module TimeHelper

		# Valid languages for reports 
		TIME_PERIODS = BingAdsApi::Config.instance.
			reporting_constants['time_periods']

		# Public : Validates the time attribute present in some report request 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# time - Hash with the time attribute for the report request
		# 
		# Returns:: true if validation is ok, raises Exception otherwise
		# Raises:: Exception if custom date range is bad informed, or if time periods specified is unknown
		def valid_time(time)
			# Custom date range
			if time.is_a?(Hash)
				raise Exception.new("Invalid time: missing :custom_date_range_start key") if !time.key?(:custom_date_range_start)
				raise Exception.new("Invalid time: missing :custom_date_range_end key")  if !time.key?(:custom_date_range_end)
			# Time periods
			else
				return TIME_PERIODS.key?(time.to_s)
			end
			return true
		end


		# Public : Return the time attribute of the ReportRequest as a valid Hash for SOAP requests 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# keys_case - specifies the keys_case for the hash: :underscore or :camelcase
		# 
		# Returns:: Hash
		def time_to_hash(keys_case)
			raise Exception.new("Invalid time value: nil") if self.time.nil?
			
			# Custom date range
			if time.is_a?(Hash)
				return {
					get_attribute_key("custom_date_range_end", keys_case) => {
						get_attribute_key("day", keys_case) => self.time[:custom_date_range_end][:day],
						get_attribute_key("month", keys_case) => self.time[:custom_date_range_end][:month],
						get_attribute_key("year", keys_case) => self.time[:custom_date_range_end][:year],
						
					},
					get_attribute_key("custom_date_range_start", keys_case) => {
						get_attribute_key("day", keys_case) => self.time[:custom_date_range_start][:day],
						get_attribute_key("month", keys_case) => self.time[:custom_date_range_start][:month],
						get_attribute_key("year", keys_case) => self.time[:custom_date_range_start][:year],
					}
				}
			# Time periods
			else
				return TIME_PERIODS[time.to_s]
			end
		end		
		
	end
end