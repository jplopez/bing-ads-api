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
	#
	# === Usage
	#   
	#   request = BingAdsApi::CampaignPerformanceReportRequest.new(
	#     :format   => :xml,
	#     :language => :english,
	#     :report_name => "Me report",
	#     :aggregation => :hourly,
	#     :columns => [:account_name, :account_number, :time_period],
	#     # The filter is specified as a hash
	#     :filter => {
	#       # specifies the Bing expected String value
	#       :ad_distribution => "Search", 
	#       # specifies criteria as a snake case symbol
	#       :device_os => :android,
	#       :device_type => :tablet,
	#       # criteria nil is similar to not specify it at all
	#       :status => nil },
	#     :scope => { 
	#       :account_ids => [123456, 234567],
	#       :campaigns => [<BingAdsApi::CampaignReportScope>] },
	#     # predefined date
	#     :time => :this_week)
	#   
	#   request2 = BingAdsApi::CampaignPerformanceReportRequest.new(
	#     :format   => :csv,
	#     :language => :french,
	#     :report_name => "Me report",
	#     :aggregation => :daily,
	#     :columns => [:account_name, :account_number, :time_period],
	#     # no filter is specified 
	#     :scope => { 
	#       :account_ids => [123456, 234567],
	#       :campaigns => [<BingAdsApi::CampaignReportScope>] },
	#     # Custom date range
	#     :time => {
	#       :custom_date_range_start => {:day => 1, :month => 12, :year => 2013},
	#       :custom_date_range_end   => {:day => 12, :month => 12, :year => 2013} }
	#     )
	class CampaignPerformanceReportRequest < BingAdsApi::PerformanceReportRequest
		
		# Valid Columns for this report request 
		COLUMNS = BingAdsApi::Config.instance.
			reporting_constants['campaign_performance_report']['columns']
		
		# Valid Filters for this report request 
		FILTERS = BingAdsApi::Config.instance.
			reporting_constants['campaign_performance_report']['filter']
		
		
		# Public : Constructor. Adds a validations for the columns, filter 
		# and scope attributes 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# === Parameters
		# * +attributes+ - Hash with the report request attributes
		#
		# === Example
		#   
		#   request = BingAdsApi::CampaignPerformanceReportRequest.new(
		#     :format   => :xml,
		#     :language => :english,
		#     :report_name => "Me report",
		#     :aggregation => :hourly,
		#     :columns => [:account_name, :account_number, :time_period],
		#     # The filter is specified as a hash
		#     :filter => {
		#       # specifies the Bing expected String value
		#       :ad_distribution => "Search", 
		#       # specifies criteria as a snake case symbol
		#       :device_os => :android,
		#       :device_type => :tablet,
		#       # criteria nil is similar to not specify it at all
		#       :status => nil },
		#     :scope => { 
		#       :account_ids => [123456, 234567],
		#       :campaigns => [<BingAdsApi::CampaignReportScope>] },
		#     # predefined date
		#     :time => :this_week)
		#   
		#   request2 = BingAdsApi::CampaignPerformanceReportRequest.new(
		#     :format   => :csv,
		#     :language => :french,
		#     :report_name => "Me report",
		#     :aggregation => :daily,
		#     :columns => [:account_name, :account_number, :time_period],
		#     # no filter is specified 
		#     :scope => { 
		#       :account_ids => [123456, 234567],
		#       :campaigns => [<BingAdsApi::CampaignReportScope>] },
		#     # Custom date range
		#     :time => {
		#       :custom_date_range_start => {:day => 1, :month => 12, :year => 2013},
		#       :custom_date_range_end   => {:day => 12, :month => 12, :year => 2013} }
		#     )
		def initialize(attributes={})
			raise Exception.new("Invalid columns") if !valid_columns(COLUMNS, attributes[:columns])
			raise Exception.new("Invalid filters") if !valid_filter(FILTERS, attributes[:filter])
			raise Exception.new("Invalid scope") if !valid_scope(attributes[:scope])
			super(attributes)
		end
		
		
		def to_hash(keys = :underscore)
			hash = super(keys)
			hash[get_attribute_key('columns', keys)] = 
				columns_to_hash(COLUMNS, columns, keys)
			hash[get_attribute_key('filter', keys)] = 
				filter_to_hash(FILTERS, keys)
			hash[get_attribute_key('scope', keys)] = scope_to_hash(keys) 
			return hash
		end
		
		
		private
			
			def valid_scope(scope)
				raise Exception.new("Invalid scope: no account_ids key") if !scope.key?(:account_ids)
				raise Exception.new("Invalid scope: no campaigns key") if !scope.key?(:campaigns)
				return true
			end
			
			
			def scope_to_hash(keys_case=:underscore)
				hash = object_to_hash(scope, keys_case)
				hash[get_attribute_key('campaigns', keys_case)] = 
					{ "CampaignReportScope" => hash[get_attribute_key('campaigns', keys_case)] }
				return hash
			end
	end
	
end