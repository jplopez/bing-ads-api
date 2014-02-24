# -*- encoding : utf-8 -*-
module BingAdsApi

	# Public : This class represents the Reporting Services 
	# defined in the Bing Ads API, to request and download reports
	# 
	# Author:: jlopezn@neonline.cl 
	# 
	# Examples 
	#  options = {
	#    :environment => :sandbox,
	#    :username => "username",
	#    :password => "pass",
	#    :developer_token => "SOME_TOKEN",
	#    :customer_id => "1234567",
	#    :account_id => "9876543" }
	#  service = BingAdsApi::Reporting.new(options)
	class Reporting < BingAdsApi::Service
		
		
		# Public : Get the status of a report request 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# === Parameters
		# +report_request_id+ - Identifier of the report request
		# 
		# === Examples 
		#   service.poll_generate_report("12345") 
		#   # => Hash 
		# 
		# Returns:: Hash with the PollGenerateReportResponse structure
		#
		# Raises:: exception
		def poll_generate_report(report_request_id)
			response = call(:poll_generate_report, 
				{report_request_id: report_request_id} )
			response_hash = get_response_hash(response, __method__)
			report_request_status = BingAdsApi::ReportRequestStatus.new(
				response_hash[:report_request_status])
			return report_request_status
		end
		
		# Public : Submits a report request 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# === Parameters
		# +report_request+ - a BingAdsApi::ReportRequest subclass instance
		# 
		# === Examples 
		# ==== CampaignPerformanceReportRequest
		#   report_request = BingAdsApi::CampaignPerformanceReportRequest.new(:format => :xml,
		#   	:language => :english, 
		#   	:report_name => "My Report",
		#   	:aggregation => :hourly, 
		#   	:columns => [:account_name, :account_number, :time_period, 
		#   		:campaign_name, :campaign_id, :status, :currency_code, 
		#   		:impressions, :clicks, :ctr, :average_cpc, :spend, 
		#   		:conversions, :conversion_rate, :cost_per_conversion, :average_cpm ],
		#   	:filter => {
		#   		# String as bing expected
		#   		:ad_distribution => "Search",
		#   		:device_os => "Windows",
		#   		# snake case symbol
		#   		:device_type => :computer,
		#   		# nil criteria
		#   		:status => nil
		#   	},
		#   	:scope => {:account_ids => 5978083, 
		#   		:campaigns => [
		#   			{:account_id => 5978083, :campaign_id => 1951230156},
		#   			{:account_id => 5978083, :campaign_id => 1951245412},
		#   			{:account_id => 5978083, :campaign_id => 1951245474}]
		#   	},
		#   	:time => {
		#   		:custom_date_range_end => {:day => 31, :month => 12, :year => 2013},
		#   		:custom_date_range_start => {:day => 1, :month => 12, :year => 2013},
		#   	})
		#   report_request_id = reporting_service.submit_generate_report(report_request)
		#   # => "1234567890"
		# 
		# Returns:: String with the requested report id
		#
		# Raises:: Exception if report_request is invalid or SOAP request failed
		def submit_generate_report(report_request)
			response = call(:submit_generate_report, 
				{report_request: report_request.to_hash(:camelcase)})
			response_hash = get_response_hash(response, __method__)
			report_request_id = response_hash[:report_request_id]
			return report_request_id
		end


		private
			def get_service_name
				"reporting"
			end

	end
end