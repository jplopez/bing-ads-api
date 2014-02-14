# -*- encoding : utf-8 -*-

module BingAdsApi
	
	# Public : Defines an error object that identifies the item within the batch of items 
	# in the request message that caused the operation to fail, and describes the reason for the failure.
	# 
	# Author jlopezn@neonline.cl 
	# 
	# Reference : http://msdn.microsoft.com/en-US/library/bing-ads-overview-batcherror.aspx
	class BatchError < BingAdsApi::DataObject
	
		attr_accessor :code, :details, :error_code, :index, :message, :type
		
		# Public : Specified to string method 
		# 
		# Author jlopezn@neonline.cl 
		def to_s
			"#{index}:#{code}:#{error_code} - #{message} (#{type})"
		end
	end
	
	# Public : Subclass of BatchError present in AdAdds operations 
	# Defines an error object that identifies the entity with the 
	# batch of entities that failed editorial review.
	# 
	# Reference : http://msdn.microsoft.com/en-US/library/bing-ads-overview-editorialerror.aspx
	# 
	# Author jlopezn@neonline.cl 
	class EditorialError < BingAdsApi::BatchError
		
		attr_accessor :appaleable, :disapproved_text, :location, :publisher_country, :reason_code
		
		# Public : Specified to string method 
		# 
		# Author jlopezn@neonline.cl 
		def to_s
			str = super() + "\n"
			str += "\tAppaleable? #{appaleable}\n" if appaleable
			str += "\tDisapproved text: #{disapproved_text}\n" if disapproved_text
			str += "\tLocation: #{location}\n" if location
			str += "\tDisapproved text: #{disapproved_text}\n" if disapproved_text
			str += "\tReason code: #{reason_code} (see: http://msdn.microsoft.com/en-US/library/bing-ads-editorialfailurereasoncodes.aspx)\n" if reason_code

		end
	end
end 
