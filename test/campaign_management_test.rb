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
		assert response.is_a?(Array), "No Array as response received"
	end

	test "add campaign" do
		
		name = "Test Campaign #{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")}"
		campaigns = [
			BingAdsApi::Campaign.new(
			:budget_type => BingAdsApi::Campaign::DAILY_BUDGET_STANDARD, 
			:conversion_tracking_enabled => "false",
			:daily_budget => 2000,
			:daylight_saving => "false",
			:description => name + " description",
			:monthly_budget => 5400,
			:name => name + " name",
			:status => BingAdsApi::Campaign::PAUSED,
			:time_zone => BingAdsApi::Campaign::SANTIAGO),
		]
		response = @service.add_campaigns(@options[:account_id], campaigns)
		
		puts "response[:campaign_ids][:long]"
		puts response[:campaign_ids][:long]
		assert !response[:campaign_ids][:long].nil?, "No campaigns id received"
	end

	test "add campaigns" do
		name = "Test Campaign #{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")}"
		campaigns = [
			BingAdsApi::Campaign.new(
				:budget_type => BingAdsApi::Campaign::DAILY_BUDGET_STANDARD, 
				:conversion_tracking_enabled => "false",
				:daily_budget => 2000,
				:daylight_saving => "false",
				:description => name + " first description",
				:monthly_budget => 5400,
				:name => name + " first name",
				:status => BingAdsApi::Campaign::PAUSED,
				:time_zone => BingAdsApi::Campaign::SANTIAGO),

			BingAdsApi::Campaign.new(
				:budget_type => BingAdsApi::Campaign::DAILY_BUDGET_STANDARD, 
				:conversion_tracking_enabled => "false",
				:daily_budget => 2500,
				:daylight_saving => "false",
				:description => name + " second description",
				:monthly_budget => 7800,
				:name => name + " second name",
				:status => BingAdsApi::Campaign::PAUSED,
				:time_zone => BingAdsApi::Campaign::SANTIAGO),

		]
		response = @service.add_campaigns(@options[:account_id], campaigns)
		puts "response.inspect"
		puts response.inspect

		puts "response[:campaign_ids][:long]"
		puts response[:campaign_ids][:long]
		assert !response[:campaign_ids][:long].nil?, "No campaigns ids received"
		assert response[:campaign_ids][:long].is_a?(Array), "No array with campaign ids received"
		assert response[:campaign_ids][:long].size == campaigns.size, "expected campaign_ids: #{campaigns.size}. Received: #{response[:campaign_ids][:long].size}"

	end


	test "update campaigns" do

		campaigns = @service.get_campaigns_by_account_id(@options[:account_id])
		assert !campaigns.nil?, "No campaigns received"

		campaigns.each do |campaign|
			campaign.description = campaign.description + " updated #{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")}"
			campaign.status = nil
		end 

		response = @service.update_campaigns(@options[:account_id], campaigns)

		puts "UpdateCampaigns response"
		puts response.inspect
		assert !response.nil?, "No response received"

	end


	test "get ad groups by campaign" do
		campaigns = @service.get_campaigns_by_account_id(@options[:account_id])
		assert !campaigns.empty?, "No campaigns received for account id #{@options[:account_id]}" 
		campaign_id = campaigns.first.id

		response = @service.get_ad_groups_by_campaign_id(campaign_id)

		puts "GetAdGroupsByCampaignId response :"
		puts response.inspect
		
		assert !response.empty?, "No ad groups received from campaign #{campaign_id}"
		assert response.is_a?(Array), "No array response received"
	end


	test "get ad groups by ids" do
		campaigns = @service.get_campaigns_by_account_id(@options[:account_id])
		assert !campaigns.empty?, "No campaigns received for account id #{@options[:account_id]}" 
		campaign_id = campaigns.first.id

		groups = @service.get_ad_groups_by_campaign_id(campaign_id)
		
		ad_group_ids = groups.map{ |gr| gr.id }
		response = @service.get_ad_groups_by_ids(campaign_id, ad_group_ids)

		puts "GetAdGroupsByIds response :"
		puts response.inspect
		
		assert !response.nil?, "No ad groups received in campaign #{campaign_id} where ad_group_ids #{ad_group_ids}"
		assert response.size == ad_group_ids.size, "Excpected #{ad_group_ids.size} ad groups. Received #{response.size}"

	end

	test "add ad group" do

		campaigns = @service.get_campaigns_by_account_id(@options[:account_id])
		assert !campaigns.empty?, "No campaigns received for account id #{@options[:account_id]}" 
		campaign_id = campaigns.first.id
		
		name = "Ad Group #{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")}"
		ad_groups = [
			BingAdsApi::AdGroup.new(
			:ad_distribution => BingAdsApi::AdGroup::SEARCH,
			:language => BingAdsApi::AdGroup::SPANISH,
			:name => name + " name",
			:pricing_model => BingAdsApi::AdGroup::CPC,
			:bidding_model => BingAdsApi::AdGroup::KEYWORD)
		]
		response = @service.add_ad_groups(campaign_id, ad_groups)
		
		puts "AddAdGroups response[:ad_group_ids][:long]"
		puts response[:ad_group_ids][:long]
		assert !response[:ad_group_ids][:long].nil?, "No ad groups id received"

	end


	test "add ad groups" do
		
		campaigns = @service.get_campaigns_by_account_id(@options[:account_id])
		assert !campaigns.empty?, "No campaigns received for account id #{@options[:account_id]}" 
		campaign_id = campaigns.first.id
		
		name = "Ad Group #{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")}"
		ad_groups = [
			BingAdsApi::AdGroup.new(
			:ad_distribution => BingAdsApi::AdGroup::SEARCH,
			:language => BingAdsApi::AdGroup::SPANISH,
			:name => name + " name",
			:pricing_model => BingAdsApi::AdGroup::CPC,
			:bidding_model => BingAdsApi::AdGroup::KEYWORD),

			BingAdsApi::AdGroup.new(
			:ad_distribution => BingAdsApi::AdGroup::SEARCH,
			:language => BingAdsApi::AdGroup::SPANISH,
			:name => name + " second name",
			:pricing_model => BingAdsApi::AdGroup::CPC,
			:bidding_model => BingAdsApi::AdGroup::KEYWORD)

		]
		response = @service.add_ad_groups(campaign_id, ad_groups)
		
		puts "AddAdGroups response[:ad_group_ids][:long]"
		puts response[:ad_group_ids][:long]
		assert !response[:ad_group_ids][:long].nil?, "No ad groups id received"
		assert response[:ad_group_ids][:long].is_a?(Array), "No array with ad group ids received"
		assert response[:ad_group_ids][:long].size == ad_groups.size, "expected ad_group_ids: #{ad_groups.size}. Received: #{response[:ad_group_ids][:long].size}"

	end


	test "update ad groups" do
		campaigns = @service.get_campaigns_by_account_id(@options[:account_id])
		assert !campaigns.empty?, "No campaigns received for account id #{@options[:account_id]}" 
		campaign_id = campaigns.first.id
		
		ad_groups = @service.get_ad_groups_by_campaign_id(campaign_id)
		
		ad_groups_to_update = ad_groups.map do |ad_group|
			BingAdsApi::AdGroup.new(
				:id => ad_group.id, 
				:name => ad_group.name + " updated #{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")}" )
		end
		
		response = @service.update_ad_groups(campaign_id, ad_groups_to_update)
		
		puts "UpdateAdGroups response"
		puts response
		assert !response.nil?, "No response received"

	end
	
	
	test "add ad" do
		
	end
	
	
	test "add ads" do
		
	end
	
	
	test "get ads by group id" do
		
	end
	
	
	test "get ads by ids" do
		
	end
	
	
	test "update ads" do
		
	end
	
	
end
