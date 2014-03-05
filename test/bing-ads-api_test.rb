# -*- encoding : utf-8 -*-
require 'test_helper'

# Public : Test Case for general purpose methods, helper and modules 
# 
# Author:: jlopezn@neonline.cl 
class BingAdsApiTest < ActiveSupport::TestCase

	def setup
		@username = ""
		@password = ""
		@developer_token = ""
		@customer_id = ""
		@account_id = ""
		@auth_token = ""
	end

	test "truth" do
		assert_kind_of Module, BingAdsApi
	end
	
	test "load config" do
		config = BingAdsApi::Config.instance
		assert !config.nil?, "Config class not instantiated"
		assert !config.config.nil?, "Config file not loaded"
	end

	test "config constants" do
		config = BingAdsApi::Config.instance
		
		assert !config.common_constants.nil?, "No common constants"
		assert !config.campaign_management_constants.nil?, "No campaign management constants"
		assert !config.reporting_constants.nil?, "No reporting constants"
	end

	test "config common constants" do
		config = BingAdsApi::Config.instance
		assert !config.common_constants['time_zones'].nil?, "No time_zones common constants"
		assert !config.common_constants['time_zones']['santiago'].nil?, "No time_zones santiago "
	end

	test "get sandbox wsdl" do
		config = BingAdsApi::Config.instance
		
		assert !config.service_wsdl(:sandbox, :campaign_management).nil?, 
			"No wsdl for sandbox and campaign_management"
		assert !config.service_wsdl(:sandbox, :reporting).nil?, 
			"No wsdl for sandbox and reporting"
	end


	test "get production wsdl" do
		config = BingAdsApi::Config.instance
		
		assert !config.service_wsdl(:production, :campaign_management).nil?, 
			"No wsdl for production and campaign_management"
		assert !config.service_wsdl(:production, :reporting).nil?, 
			"No wsdl for production and reporting"
		
	end


	test "create client proxy" do
		options = {
			:username => @username,
			:password => @password,
			:developer_token => @developer_token,
			:customer_id => @customer_id,
			:account_id => @account_id,
			:wsdl_url => "https://api.sandbox.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v9/CampaignManagementService.svc?singleWsdl"
		}
		client = BingAdsApi::ClientProxy.new(options)
		#puts client.inspect
		assert !client.nil?, "Client proxy not created"

		#puts client.service
		assert !client.service.nil?, "Service client not created"
	end


	test "create client proxy with additional settings" do
		options = {
			:username => @username,
			:password => @password,
			:developer_token => @developer_token,
			:customer_id => @customer_id,
			:account_id => @account_id,
			:wsdl_url => "https://api.sandbox.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v9/CampaignManagementService.svc?singleWsdl",
			:proxy => {
				:logger => Rails.logger, 
				:encoding => "UTF-8"
			}
		}
		client = BingAdsApi::ClientProxy.new(options)
		#puts client.inspect
		assert !client.nil?, "Client proxy not created"

		#puts client.service
		assert !client.service.nil?, "Service client not created"
	end


	test "create oauth client proxy" do
		
		options = {
			:authentication_token => @auth_token,
			:developer_token => @developer_token,
			:customer_id => @customer_id,
			:account_id => @account_id,
			:wsdl_url => "https://api.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v9/CampaignManagementService.svc?singleWsdl",
			:proxy => {
				:logger => Rails.logger, 
				:encoding => "UTF-8"
			}
		}
		client = BingAdsApi::ClientProxy.new(options)
		#puts client.inspect
		assert !client.nil?, "Client proxy not created"

		#puts client.service
		assert !client.service.nil?, "Service client not created"
		
		#call service method
		assert_nothing_raised(Exception, "Service call raised exception") {
			response = client.call(:get_campaigns_by_account_id, 
				message: {Account_id: "2642632"})
			puts response
		}
	end


	test "call service" do
		options = {
			:username => @username,
			:password => @password,
			:developer_token => @developer_token,
			:customer_id => @customer_id,
			:account_id => @account_id,
			:wsdl_url => "https://api.sandbox.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v9/CampaignManagementService.svc?singleWsdl"
		}
		
		client = BingAdsApi::ClientProxy.new(options)
		assert !client.nil?, "Client proxy not created"
		
		response = client.service.call(:get_campaigns_by_account_id, 
			message: { Account_id: client.account_id})
		#puts response.inspect
		assert response, "No responde received"
	end

	test "create and call from config" do
		config = BingAdsApi::Config.instance
		options = {
			:username => @username,
			:password => @password,
			:developer_token => @developer_token,
			:customer_id => @customer_id,
			:account_id => @account_id,
			:wsdl_url => config.service_wsdl(:sandbox, :campaign_management)
		}
		
		client = BingAdsApi::ClientProxy.new(options)
		assert !client.nil?, "Client proxy not created"
		
		response = client.service.call(:get_campaigns_by_account_id, 
			message: { Account_id: client.account_id})
		#puts response.inspect
		assert response, "No responde received"
		
	end

end
