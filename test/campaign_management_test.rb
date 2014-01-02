# -*- encoding : utf-8 -*-
require 'test_helper'

class CampaignManagementTest < ActiveSupport::TestCase

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
		@service = BingAdsApi::CampaignManagement.new(@options)

	end

	test "truth" do
		assert_kind_of Module, BingAdsApi
	end
	
	test "initialize" do
		@service = BingAdsApi::CampaignManagement.new(@options)
		assert !@service.nil?, "CampaignManagement service not instantiated"
	end

	test "get campaigns by account" do
		response = @service.get_campaigns_by_account_id(@options[:account_id])
		assert !response.nil?, "No response received"
		assert !response.is_a?(Hash), "No Hash as response received"
	end

	test "add campaigns" do
		campaigns = [
			BingAdsApi::Campaign.new(
			:budget_type => BingAdsApi::Campaign.BUDGET_LIMIT_TYPE['daily_budget_standard'], 
			:conversion_tracking_enabled => "false",
			:daily_budget => 2000,
			:daylight_saving => "false",
			:description => "Some Campaign",
			:monthly_budget => 5400,
			:name => "Some campaign",
			:status => BingAdsApi::Campaign.CAMPAIGN_STATUS['paused'],
			:time_zone => BingAdsApi::Campaign.TIME_ZONES['santiago']),
		]
		response = service.add_campaigns(options[:account_id], campaigns)
		puts "response.inspect"
		puts response.inspect
	end
end
