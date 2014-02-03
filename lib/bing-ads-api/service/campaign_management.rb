# -*- encoding : utf-8 -*-
module BingAdsApi
	
	class CampaignManagement < BingAdsApi::Service
		
		# Public : Constructor 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# options - Hash with the parameters for the client proxy and the environment
		# 
		# Examples 
		#   options = {
		#     :environment => :sandbox,
		#     :username => "username",
		#     :password => "password",
		#     :developer_token => "DEV_TOKEN",
		#     :customer_id => "123456",
		#     :account_id => "654321"
		#   }
		#   service = BingAdsApi::CampaignManagement.new(options)
		def initialize(options={})
			super(options)
		end


		#########################
		## Operations Wrappers ##
		#########################

		# Public : Returns a Hash with the 
		#   'get_campaigns_by_account_id_response' object structure 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# account_id - account who owns the campaigns
		# 
		# Examples 
		#   campaign_management_service.get_campaigns_by_account_id(1) 
		#   # => Hash 
		# 
		# Returns Hash with the 'get_campaigns_by_account_id_response' object structure
		# Raises exception
		def get_campaigns_by_account_id(account_id)
			response = call(:get_campaigns_by_account_id, 
				{account_id: account_id})
			response_hash = get_response_hash(response, __method__)
			campaigns = response_hash[:campaigns][:campaign].map do |camp_hash|
				BingAdsApi::Campaign.new(camp_hash)
			end
			return campaigns
		end


		# Public : Adds a campaign to the specified account 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# account_id - account who will own the newly campaigns
		# campaigns - An array of BingAdsApi::Campaign
		# 
		# Examples 
		#   service.add_campaigns(1, [<BingAdsApi::Campaign>]) 
		#   # => <Hash> 
		# 
		# Returns hash with the 'add_campaigns_response' structure
		# Raises exception
		def add_campaigns(account_id, campaigns)
			
			camps = []
			if campaigns.is_a? Array
				camps = campaigns.map{ |camp| camp.to_hash(:camelcase) }
			elsif campaigns.is_a? BingAdsApi::Campaign
				camps = campaigns.to_hash
			else 
				raise "campaigns must be an array of BingAdsApi::Campaigns"
			end
			message = {
				:account_id => account_id, 
				:campaigns => {:campaign => camps} }
			puts message
			response = call(:add_campaigns, message)
			return get_response_hash(response, __method__)
		end


		# Public : Returns the specified ad groups that belongs to the 
		#   specified campaign 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# campaign_id   - campaign id
		# ad_groups_ids - array with ids from ad groups
		# 
		# Examples 
		#   service.get_ad_groups_by_ids(1, [1,2,3]) 
		#   # => Array[AdGroups] 
		# 
		# Returns Array with the ad groups specified in the ad_groups_ids array
		# Raises exception
		def get_ad_groups_by_ids(campaign_id, ad_groups_ids)
			response = call(:get_ad_groups_by_ids, 
				{campaign_id: campaign_id, ad_groups_ids: ad_groups_ids})
			response_hash = get_response_hash(response, __method__)
			ad_groups = response_hash[:ad_groups][:ad_group].map do |ad_group_hash|
				BingAdsApi::AdGroup.new(ad_group_hash)
			end
			return ad_groups
			
		end


		# Public : Returns all the ad groups that belongs to the 
		#   specified campaign 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# campaign_id   - campaign id
		# 
		# Examples 
		#   service.get_ad_groups_by_campaign_id(1) 
		#   # => Array[AdGroups] 
		# 
		# Returns Array with all the ad groups present in campaign_id
		# Raises exception
		def get_ad_groups_by_campaign_id(campaign_id)
			response = call(:get_ad_groups_by_campaign_id, 
				{campaign_id: campaign_id})
			response_hash = get_response_hash(response, __method__)
			ad_groups = response_hash[:ad_groups][:ad_group].map do |ad_group_hash|
				BingAdsApi::AdGroup.new(ad_group_hash)
			end
			return ad_groups
		end


		# Public : Adds 1 or more AdGroups to a Campaign 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# campaing_id - the campaign id where the ad groups will be added
		# ad_groups - Array[BingAdsApi::AdGroup] ad groups to be added
		# 
		# Examples 
		#   service.add_ad_groups(1, [<BingAdsApi::AdGroup>]) 
		#   # => <Hash> 
		# 
		# Returns Hash with the 'add_ad_groups_response' structure
		# Raises exception
		def add_ad_groups(campaign_id, ad_groups)
			
			groups = []
			if ad_groups.is_a? Array
				groups = ad_groups.map{ |gr| gr.to_hash(:camelcase) }
			elsif ad_groups.is_a? BingAdsApi::AdGroup
				groups = ad_groups.to_hash
			else 
				raise "ad_groups must be an array of BingAdsApi::AdGroup"
			end
			message = {
				:campaign_id => campaign_id, 
				:ad_groups => {:ad_group => groups} }
			puts message
			response = call(:add_ad_groups, message)
			return get_response_hash(response, __method__)
		end


		def get_ads(account_id, campaign_id, ads_group_id)
			
		end


		def add_ads(account_id, campaign_id, ads_group_id, ads)
			
		end


		private
			def get_service_name
				"campaign_management"
			end
	end

end