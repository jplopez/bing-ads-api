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
			return get_response_hash(response, __method__)
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
				camps = campaigns.map{ |camp| {campaign: camp.to_hash} }
			elsif campaigns.is_a? BingAdsApi::Campaign
				camps = campaigns.to_hash
			else 
				raise "campaigns must be an array of BingAdsApi::Campaigns"
			end
			message = {account_id: account_id, 
				campaigns: camps}
			response = call(:add_campaigns, message)
			return get_response_hash(response, __method__)
		end


		private
			def get_service_name
				"campaign_management"
			end
	end

end