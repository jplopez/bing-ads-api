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
	# Author jlopezn@neonline.cl 
	class PerformanceReportRequest < BingAdsApi::ReportRequest
		
		# Valid aggregations for reports 
		AGGREGATIONS = BingAdsApi::Config.instance.
			reporting_constants['aggregation']

		attr_accessor :aggregation, :columns, :filter, :scope, :time


		# Public : Constructor. Adds validations to aggregations and time
		# 
		# Author jlopezn@neonline.cl 
		# 
		# === Parameters
		# attributes - Hash with Performance report request
		# 
		def initialize(attributes={})
			raise Exception.new("Invalid aggregation '#{attributes[:aggregation]}'") if !valid_aggregation(attributes[:aggregation])
			raise Exception.new("Invalid time") if !valid_time(attributes[:time])
			super(attributes)
		end


		private
		
			def valid_aggregation(aggregation)
				return AGGREGATIONS.key?(aggregation.to_s)
			end

	end
	
end