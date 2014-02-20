# -*- encoding : utf-8 -*-

module BingAdsApi::Helpers
	
	##
	# Public : Utility module for filter attribute in +ReportRequest+ derived classes
	# 
	# Author:: jlopezn@neonline.cl 
	# 
	module FilterHelper
		
		include BingAdsApi::SOAPHasheable
		
		
		# Valid filters values for each known criteria
		FILTERS_CRITERIA = BingAdsApi::Config.instance.
			reporting_constants['filters']
		
		
		# Internal : Validates the filter attribute at the ReporRequest initialization
		# At the first invalid filter criteria or value detected this method raises Exception.
		# If all filter criteria and values are ok, this method returns true 
		# Valid filter criteria are validated against FILTERS_CRITERIA constant
		# Valid filter values are validated against FILTERS constant
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# === Parameters
		# valid_filters - Hash with the set of valid filter values
		# filter - Hash with the filter criteria and values
		# 
		# Returns:: true if filter is valid
		# 
		# Raises:: Exception at the first invalid filter criteria o value
		def valid_filter(valid_filters, filter)
			if filter && filter.is_a?(Hash)
				filter.keys.each do |filter_key|
					# validates if filter criteria is recognized
					raise Exception.new("Invalid filter criteria '#{filter_key.to_s}'") if !valid_filters.key?(filter_key.to_s)
					# validates the filter criteria value
					valid_filter_value(filter_key, filter[filter_key])
				end
			end
			return true
		end
		
		
		# Internal : Validates a specific filter criteria and his value 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# key - filter criteria to evaluate
		# value - filter criteria to be evaluate
		# 
		# Returns:: true if validation runs ok. Raise exception otherwise
		#
		# Raises:: Exception if filter value provided is not valid
		def valid_filter_value(key, value)
			return true if value.nil?
			return true if solve_filter_value(key, value)
		end
		
		
		# Public : Returns the filter attribute as a Hash to SOAP requests 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# filter - Hash with the filter values
		# 
		# Returns:: Hash
		def filter_to_hash(valid_filters, keys_case=:undescore)
			hashed_filter = {}
			filter.each do |key, value|
				hashed_filter[get_attribute_key(key, keys_case)] = solve_filter_value(key, value)
			end
			return hashed_filter
		end


		# Internal:: Solves the Bing value for the given filter attribute 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# === Parameters
		# * +filter_criteria+ - String or symbol with the filter attribute to be solved
		# 
		# === Examples 
		#   solve_filter_value(:ad_distribution, :search) 
		#   # => "Search" 
		# 
		#   solve_filter_value(:ad_distribution, :other) 
		#   # => Exception "Invalid filter name 'other' for 'ad_distribution' criteria"
		# 
		#   solve_filter_value(:ad_distribution, "Search") 
		#   # => "Search" 
		# 
		#   solve_filter_value(:ad_distribution, "Other") 
		#   # => Exception "Invalid filter value 'Other' for 'ad_distribution' criteria"
		# 
		# Returns:: String with the Bing value for the filter criteria.
		# 
		# Raises:: Exception if the filter's criteria or value are unknown
		def solve_filter_value(filter_criteria, filter_value)
			
			filter_criteria_values = FILTERS_CRITERIA[filter_criteria.to_s]
			if filter_value.is_a?(String)
				if filter_criteria_values.value?(filter_value)
					return filter_value
				else
					raise Exception.new("Invalid filter value '#{filter_value}' for '#{filter_criteria}' criteria")
				end 
			elsif filter_value.is_a?(Symbol)
				if filter_criteria_values.key?(filter_value.to_s)
					return filter_criteria_values[filter_value.to_s]
				else
					raise Exception.new("Invalid filter name '#{filter_value}' for '#{filter_criteria}' criteria")
				end
			end
			return nil
		end


	end
end