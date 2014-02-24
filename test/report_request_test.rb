# -*- encoding : utf-8 -*-
require 'test_helper'

# Public : Test case for ReportRequest an its subclasses 
# 
# Author:: jlopezn@neonline.cl 
class ReportRequestTest < ActiveSupport::TestCase

	def setup
		
		@config = BingAdsApi::Config.instance
		@options = {
			:environment => :sandbox,
			:username => "desarrollo_neonline",
			:password => "neonline2013",
			:developer_token => "BBD37VB98",
			:customer_id => "21021746",
			:account_id => "5978083"
		}
		@service = BingAdsApi::Reporting.new(@options)

	end

	test "truth" do
		assert_kind_of Module, BingAdsApi
	end
	
	test "initialize report request" do
		assert_nothing_raised(Exception, "Report request not instantiated") {
			report_request = BingAdsApi::ReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:return_only_complete_data => true)
			puts "report request"
			puts report_request.to_hash(:camelcase)
		}

	end


	test "should raise exception" do
		assert_raises(Exception, "Bad format not raised") {
			report_request = BingAdsApi::ReportRequest.new(:format => :invalid,
				:language => :english, :report_name => "My Report",
				:return_only_complete_data => true)
		}

		assert_raises(Exception, "Bad language not raised") {
			report_request = BingAdsApi::ReportRequest.new(:format => :xml,
				:language => :swahili, :report_name => "My Report",
				:return_only_complete_data => true)
		}

	end
	
	
	test "initialize performance report request" do
		assert_nothing_raised(Exception, "Performance Report request not instantiated") {
			performance_report_request = BingAdsApi::PerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, :time => :today)
			puts "performance report request"
			puts performance_report_request.to_hash(:camelcase)
		}
	end


	test "should raise aggregation exception" do
		assert_raises(Exception, "Bad aggregation not raised") {
			performance_report_request = BingAdsApi::PerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :invalid_aggregation)
		}

	end


	test "should raise time exception" do
		assert_raises(Exception, "Bad aggregation not raised") {
			performance_report_request = BingAdsApi::PerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :weekly)
		}

	end


	test "initialize campaign performance report request" do
		assert_nothing_raised(Exception, "CampaignPerformanceReportRequest not instantiated") {
			performance_report_request = BingAdsApi::CampaignPerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, :time => :today, 
				:columns => [:account_name, :account_number, :time_period ],
				:filter => {
					# String as bing expected
					:ad_distribution => "Search",
					:device_os => "Windows",
					# snake case symbol
					:device_type => :computer,
					# nil criteria
					:status => nil
				},
				:scope => {:account_ids => 12345, 
				:campaigns => [
					{:account_id => 1234, :campaign_id => 1234},
					{:account_id => 1234, :campaign_id => 1234},
					{:account_id => 1234, :campaign_id => 1234}]
				})
			puts "campaign performance report request 1"
			puts performance_report_request.to_hash(:camelcase)

			performance_report_request = BingAdsApi::CampaignPerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, 
				:time => {
					:custom_date_range_start => {
						:day => 1,
						:month => 12,
						:year => 2013
					}, 
					:custom_date_range_end => {
						:day => 31,
						:month => 12,
						:year => 2013
					}
				}, 
				:columns => [:account_name, :account_number, :time_period ],
				:filter => {
					# String as bing expected
					:ad_distribution => "Search",
					:device_os => "Windows",
					# snake case symbol
					:device_type => :computer,
					# nil criteria
					:status => nil
				},
				:scope => {:account_ids => 12345, 
				:campaigns => []})
			puts "campaign performance report request 2"
			puts performance_report_request.to_hash(:camelcase)


		}
	end


	test "initialize account performance report request" do
		assert_nothing_raised(Exception, "AccountPerformanceReportRequest not instantiated") {
			performance_report_request = BingAdsApi::AccountPerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, 
				:columns => [:account_name, :account_number, :time_period ],
				:filter => {
					# String as bing expected
					:ad_distribution => "Search",
					# snake case symbol
					:device_os => :windows,
					# no specified value
					:device_type => nil
				},
				:scope => {:account_ids => 12345}, 
				:time => :today )
			puts "account performance report request 1"
			puts performance_report_request.to_hash(:camelcase)

			performance_report_request = BingAdsApi::AccountPerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, 
				:columns => [:account_name, :account_number, :time_period ],
				:filter => {
					# String as bing expected
					:ad_distribution => "Search",
					# snake case symbol
					:device_os => :windows,
					# no specified value
					:device_type => nil
				},
				:scope => {:account_ids => 12345},
				:time => {
					:custom_date_range_start => {
						:day => 1,
						:month => 12,
						:year => 2013
					}, 
					:custom_date_range_end => {
						:day => 31,
						:month => 12,
						:year => 2013
					}
				})
			puts "account performance report request 2"
			puts performance_report_request.to_hash(:camelcase)

		}
	end


	test "should raise column exception " do
		assert_raises(Exception, "Bad column name for CampaignPerformanceReportRequest not raised") {
			performance_report_request = BingAdsApi::CampaignPerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, :time => :today, 
				:columns => [:account_name, :account_number, :time_period, :unknown_column ],
				:scope => {:account_ids => 12345, 
				:campaigns => []})
		}


		assert_raises(Exception, "Bad column value for CampaignPerformanceReportRequest not raised") {
			performance_report_request = BingAdsApi::CampaignPerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, :time => :today, 
				:columns => [:account_name, :account_number, :time_period, "UnknownColumn" ],
				:scope => {:account_ids => 12345, 
				:campaigns => []})
		}
	end


	test "should raise scope exception " do
		assert_raises(Exception, "Bad scope for account_ids not raised") {
			performance_report_request = BingAdsApi::CampaignPerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, :time => :today, 
				:columns => [:account_name, :account_number, :time_period ],
				:scope => { :campaigns => []})
		}

		assert_raises(Exception, "Bad scope for campaigns not raised") {
			performance_report_request = BingAdsApi::CampaignPerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, :time => :today, 
				:columns => [:account_name, :account_number, :time_period ],
				:scope => {:account_ids => 12345 })
		}

	end


	test "campaign performance filter " do
		assert_nothing_raised(Exception, "Bad filter for CampaignPerformanceReportRequest") {
			performance_report_request = BingAdsApi::CampaignPerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, :time => :today, 
				:columns => [:account_name, :account_number, :time_period ],
				:filter => {
					# String as bing expected
					:ad_distribution => "Search",
					:device_os => "Windows",
					# snake case symbol
					:device_type => :computer,
					# nil criteria
					:status => nil
				},
				:scope => {:account_ids => 12345, 
				:campaigns => []})
		}
	end


	test "should raise campaign performance filter exception " do
		assert_raises(Exception, "Bad filter string for CampaignPerformanceReportRequest not raised") {
			performance_report_request = BingAdsApi::CampaignPerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, :time => :today, 
				:columns => [:account_name, :account_number, :time_period ],
				:filter => {
					# Wrong String as bing expected
					:ad_distribution => "Searched",
					:device_os => "Windows",
					# snake case symbol
					:device_type => :computer,
					# nil criteria
					:status => nil
				},
				:scope => {:account_ids => 12345, 
				:campaigns => []})
		}

		assert_raises(Exception, "Bad filter symbol for CampaignPerformanceReportRequest not raised") {
			performance_report_request = BingAdsApi::CampaignPerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, :time => :today, 
				:columns => [:account_name, :account_number, :time_period ],
				:filter => {
					# Wrong String as bing expected
					:ad_distribution => "Search",
					:device_os => "Windows",
					# Wrong snake case symbol
					:device_type => :notebook,
					# nil criteria
					:status => nil
				},
				:scope => {:account_ids => 12345, 
				:campaigns => []})
		}

		assert_raises(Exception, "Bad filter criteria for CampaignPerformanceReportRequest not raised") {
			performance_report_request = BingAdsApi::CampaignPerformanceReportRequest.new(:format => :xml,
				:language => :english, :report_name => "My Report",
				:aggregation => :hourly, :time => :today, 
				:columns => [:account_name, :account_number, :time_period ],
				:filter => {
					# Wrong filter criteria. ie: invalid key
					:not_a_valid_criteria => "Bleh",
				},
				:scope => {:account_ids => 12345, 
				:campaigns => []})
		}

	end

end
