# -*- encoding : utf-8 -*-
require 'test_helper'

# Public : Test case for Reporting services 
# 
# Author:: jlopezn@neonline.cl 
class ReportingTest < ActiveSupport::TestCase

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
	
	test "initialize" do
		@service = BingAdsApi::Reporting.new(@options)
		puts @service.client_proxy.wsdl_url
		assert !@service.nil?, "Reporting service not instantiated"
	end


	test "should submit campaign performance report" do
		
		report_request = BingAdsApi::CampaignPerformanceReportRequest.new(:format => :xml,
			:language => :english, 
			:report_name => "My Report",
			:aggregation => :hourly, 
			:columns => [:account_name, :account_number, :time_period, 
				:campaign_name, :campaign_id, :status, :currency_code, 
				:impressions, :clicks, :ctr, :average_cpc, :spend, 
				:conversions, :conversion_rate, :cost_per_conversion, :average_cpm ],
			:filter => {
				# String as bing expected
				:ad_distribution => "Search",
				:device_os => "Windows",
				# snake case symbol
				:device_type => :computer,
				# nil criteria
				:status => nil
			},
			:scope => {:account_ids => 5978083, 
				:campaigns => [
					{:account_id => 5978083, :campaign_id => 1951230156},
					{:account_id => 5978083, :campaign_id => 1951245412},
					{:account_id => 5978083, :campaign_id => 1951245474}]
			},
			:time => {
				:custom_date_range_end => {:day => 31, :month => 12, :year => 2013},
				:custom_date_range_start => {:day => 1, :month => 12, :year => 2013},
			})
		
		report_request_id = nil
		assert_nothing_raised(Exception, "Submit generate report raised exception") {
			report_request_id = @service.submit_generate_report(report_request)
		}
		
		
		assert !report_request_id.nil?, "No report requeset id received"
		puts "report_request_id #{report_request_id}"
		
	end


	test "should submit account performance report" do
		
		report_request = BingAdsApi::AccountPerformanceReportRequest.new(:format => :xml,
			:language => :english, 
			:report_name => "My Report",
			:aggregation => :hourly, 
			:columns => [:account_name, :account_number, :time_period, 
				:currency_code, :impressions, :clicks, :ctr, :average_cpc, :spend, 
				:conversions, :cost_per_conversion, :average_cpm ],
			:filter => {
				# String as bing expected
				:ad_distribution => "Search",
				# snake case symbol
				:device_os => :windows,
				# nil criteria
				:device_type => nil
			},
			:scope => {:account_ids => 5978083 },
			:time => {
				:custom_date_range_end => {:day => 31, :month => 12, :year => 2013},
				:custom_date_range_start => {:day => 1, :month => 12, :year => 2013},
			})
		
		report_request_id = nil
		assert_nothing_raised(Exception, "Submit generate report raised exception") {
			report_request_id = @service.submit_generate_report(report_request)
		}
		
		
		assert !report_request_id.nil?, "No report request id received"
		puts "report_request_id #{report_request_id}"
		
	end


	test "initialize report request status" do
		report_request_status = BingAdsApi::ReportRequestStatus.new(:report_download_url => "http://some.url.com",
			:status => "Success")
		assert !report_request_status.nil?, "ReportRequestStatus not initialized"
	end
	
	
	test "should poll generate report" do
		report_request_id = 21265212
		report_request_status = nil
		assert_nothing_raised(Exception, "Poll generate report raised exception") {
			report_request_status = @service.poll_generate_report(report_request_id)
		}
		
		assert !report_request_status.nil?, "No report request status received"
		puts "report_request_status"
		puts report_request_status

		assert report_request_status.error?, "report request status should not be error"
	end


	test "should not poll generate report" do
		report_request_id = 5555555
		report_request_status = nil
		assert_nothing_raised(Exception, "Poll generate report raised exception") {
			report_request_status = @service.poll_generate_report(report_request_id)
		}
		
		assert !report_request_status.error?, "report request status should be error"

	end

end
