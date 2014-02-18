# -*- encoding : utf-8 -*-
require 'test_helper'

# Public : Test case for ReportRequest an its subclasses 
# 
# Author jlopezn@neonline.cl 
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
end
