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
	#   request = BingAdsApi::AccountPerformanceReportRequest.new(
	#     :format   => :xml,
	#     :language => :english,
	#     :report_name => "Me report",
	#     :aggregation => :hourly,
	#     :columns => [:account_name, :account_number, :time_period],
	#     # The filter is specified as a hash
	#     :filter => {
	#       :ad_distribution => :search, 
	#       :device_os => :android,
	#       :device_type => :tablet,
	#       :status => :submited },
	#     :scope => { 
	#       :account_ids => [123456, 234567],
	#       :campaigns => [<BingAdsApi::CampaignReportScope>] },
	#     # predefined date
	#     :time => :this_week)
	#   
	#   request2 = BingAdsApi::AccountPerformanceReportRequest.new(
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
	class AccountPerformanceReportRequest < BingAdsApi::PerformanceReportRequest
		
		# Valid Columns for this report request 
		COLUMNS = BingAdsApi::Config.instance.
			reporting_constants['account_performance_report']['columns']
		
		# Valid Filters for this report request 
		FILTERS = BingAdsApi::Config.instance.
			reporting_constants['account_performance_report']['filter']
		
		
		# Public : Constructor. Adds a validations for the columns, filter 
		# and scope attributes 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# === Parameters
		# attributes - Hash with the report request attributes
		#
		# === Example
		#   
		#   request = BingAdsApi::AccountPerformanceReportRequest.new(
		#     :format   => :xml,
		#     :language => :english,
		#     :report_name => "Me report",
		#     :aggregation => :hourly,
		#     :columns => [:account_name, :account_number, :time_period],
		#     # The filter is specified as a hash
		#     :filter => {
		#       :ad_distribution => :search, 
		#       :device_os => :android,
		#       :device_type => :tablet,
		#       :status => :submited },
		#     :scope => { 
		#       :account_ids => [123456, 234567],
		#       :campaigns => [<BingAdsApi::CampaignReportScope>] },
		#     # predefined date
		#     :time => :this_week)
		#   
		#   request2 = BingAdsApi::AccountPerformanceReportRequest.new(
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
			raise "Invalid columns" if !valid_columns(attributes[:columns])
			raise "Invalid filters" if !valid_filter(attributes[:filter])
			raise "Invalid scope" if !valid_scope(attributes[:scope])
			super(attributes)
		end

		private
			
			def valid_columns(columns)
				columns.each do |col|
					return false if !COLUMNS.key?(col.to_s)
				end
				return true
			end
			
			
			def valid_filter(filter)
				columns.each do |col|
					return false if !COLUMNS.key?(col.to_s)
				end
				return true
			end
			
			
			def valid_scope(scope)
				return false if !scope.key?(:account_ids)
				return false if !scope.key?(:campaigns)
				return true
			end
	end
	
end