# -*- encoding : utf-8 -*-

module BingAdsApi
	
	##
	# Public : Defines the base class for 'performance report requests'.
	# Do not instantiate this object. Instead, use BingAdsApi::AccountPerformanceReportRequest, 
	# BingAdsApi::CampaignPerformanceReportRequest, BingAdsApi::AdGroupPerformanceReportRequest or
	# BingAdsApi::AdPerformanceReportRequest
	# 
	# Reference: http://msdn.microsoft.com/en-us/library/bing-ads-reporting-bing-ads-reportrequest.aspx
	# 
	# Author:: jlopezn@neonline.cl 
	class PerformanceReportRequest < BingAdsApi::ReportRequest
		
		# Adds helper methods to time attribute
		include BingAdsApi::Helpers::TimeHelper

		# Adds helper methods to column attribute
		include BingAdsApi::Helpers::ColumnHelper

		# Adds helper methods to filter attribute
		include BingAdsApi::Helpers::FilterHelper


		# Valid aggregations for reports 
		AGGREGATIONS = BingAdsApi::Config.instance.
			reporting_constants['aggregation']


		attr_accessor :aggregation, :columns, :filter, :scope, :time


		# Public : Constructor. Adds validations to aggregations and time
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# === Parameters
		# attributes - Hash with Performance report request
		# 
		def initialize(attributes={})
			raise Exception.new("Invalid aggregation '#{attributes[:aggregation]}'") if !valid_aggregation(attributes[:aggregation])
			raise Exception.new("Invalid time") if !valid_time(attributes[:time])
			super(attributes)
		end


		# Public:: Returns this object as a Hash for SOAP Requests 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# === Parameters
		# * +keys_case+ - specifies the case for the hash keys
		# ==== keys_case
		# * :camelcase  - CamelCase
		# * :underscore - underscore_case
		# 
		# === Examples 
		#   performance_report_request.to_hash(:camelcase) 
		#   # => {"Format"=>"Xml", "Language"=>"English", "ReportName"=>"My Report", "Aggregation"=>"Hourly", "Time"=>"Today", "ReturnOnlyCompleteData"=>false}
		# 
		# Returns:: Hash
		def to_hash(keys_case = :underscore)
			hash = super(keys_case)
			hash[get_attribute_key('aggregation', keys_case)] = AGGREGATIONS[self.aggregation.to_s]
			hash[get_attribute_key('time', keys_case)] = time_to_hash(keys_case)
			return hash
		end

		private
		
			def valid_aggregation(aggregation)
				return AGGREGATIONS.key?(aggregation.to_s)
			end

	end
	
end