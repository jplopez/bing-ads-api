# -*- encoding : utf-8 -*-
module BingAdsApi

	# Public : This class represents the Reporting Services 
	# defined in the Bing Ads API, to request and download reports
	# 
	# Author jlopezn@neonline.cl 
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
		# Author jlopezn@neonline.cl 
		# 
		# === Parameters
		# report_request_id - Identifier of the report request
		# 
		# === Examples 
		#   service.poll_generate_report("12345") 
		#   # => Hash 
		# 
		# Returns Hash with the PollGenerateReportResponse structure
		#
		# Raises exception
		def poll_generate_report
			
		end
		
		# Public : Submits a report request 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# === Parameters
		# report_request - a BingAdsApi::ReportRequest subclass instance
		# 
		# === Examples 
		# 
		# Returns String with the requested report id
		#
		# Raises exception
		def submit_generate_report(report_request)
			
		end

		private
			def get_service_name
				"reporting"
			end

	end
end