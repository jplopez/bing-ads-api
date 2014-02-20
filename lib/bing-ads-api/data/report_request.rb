# -*- encoding : utf-8 -*-

module BingAdsApi
	
	##
	# Public : Defines the base object for all report requests.
	# Do not instantiate this object. Instead, you may instantiate one 
	# of the following report request objects which derives from this object to request a report.
	# 
	# Reference: http://msdn.microsoft.com/en-us/library/bing-ads-reporting-bing-ads-reportrequest.aspx
	# 
	# Author:: jlopezn@neonline.cl 
	class ReportRequest < BingAdsApi::DataObject
		
		# Valid Formats for reports 
		FORMATS = BingAdsApi::Config.instance.
			reporting_constants['format']
		
		# Valid languages for reports 
		LANGUAGES = BingAdsApi::Config.instance.
			reporting_constants['language']

		# Valid report request status for reports 
		REQUEST_STATUS = BingAdsApi::Config.instance.
			reporting_constants['request_status_type']
		
		attr_accessor :format, :language, :report_name, :return_only_complete_data
		
		# Public : Constructor. Adds validations to format and language attributes 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# === Parameters
		# attributes - Hash with Report request parameters
		def initialize(attributes={})
			raise Exception.new("Invalid format '#{attributes[:format]}'") if !valid_format(attributes[:format])
			raise Exception.new("Invalid language '#{attributes[:language]}'") if !valid_language(attributes[:language])
			super(attributes)
			self.return_only_complete_data = attributes[:return_only_complete_data] || false
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
		#   report_request.to_hash(:camelcase) 
		#   # => {"Format"=>"Xml", "Language"=>"English", "ReportName"=>"My Report", "ReturnOnlyCompleteData"=>true}
		# 
		# Returns:: Hash
		def to_hash(keys_case = :underscore)
			hash = super(keys_case)
			hash[get_attribute_key('format', keys_case)]   = FORMATS[self.format.to_s]
			hash[get_attribute_key('language', keys_case)] = LANGUAGES[self.language.to_s]
			return hash
		end
	
		private
		
			def valid_format(format)
				return FORMATS.key?(format.to_s)
			end
			
			
			def valid_language(language)
				return LANGUAGES.key?(language.to_s)
			end
			
	end
	
end