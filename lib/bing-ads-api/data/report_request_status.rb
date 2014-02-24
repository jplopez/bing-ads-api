# -*- encoding : utf-8 -*-

module BingAdsApi
	
	##
	# Public : Defines the status of a report request.
	# 
	# Reference: http://msdn.microsoft.com/en-US/library/bing-ads-reporting-bing-ads-reportrequeststatus.aspx
	# 
	# Author:: jlopezn@neonline.cl 
	class ReportRequestStatus < BingAdsApi::DataObject

		# Valid report request status for reports 
		REQUEST_STATUS = BingAdsApi::Config.instance.
			reporting_constants['request_status_type']
		
		attr_accessor :report_download_url, :status
		
		# Public:: Returns true if the status is success 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# Returns:: boolean
		def success?
			return status == REQUEST_STATUS['success']
		end
		
		# Public:: Returns true if the status is pending 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# Returns:: boolean
		def pending?
			return status == REQUEST_STATUS['pending']
		end
		
		# Public:: Returns true if the status is error 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# Returns:: boolean
		def error?
			return status == REQUEST_STATUS['error']
		end
		
	end
	
end