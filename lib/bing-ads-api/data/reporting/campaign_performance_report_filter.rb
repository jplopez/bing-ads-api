# -*- encoding : utf-8 -*-

module BingAdsApi
	
	##
	# Public : Defines the criteria to use to filter the campaign performance report data.
	# 
	# Reference: http://msdn.microsoft.com/en-US/library/bing-ads-reporting-campaignperformancereportfilter.aspx
	# 
	# Author:: jlopezn@neonline.cl 
	class CampaignPerformanceReportFilter < BingAdsApi::DataObject
		
		attr_accessor :ad_distribution, :device_os, :device_type, :status
		
	end
	
end