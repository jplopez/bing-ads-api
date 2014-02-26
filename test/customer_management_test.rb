# -*- encoding : utf-8 -*-
require 'test_helper'

# Public : Test case for Customer Management services 
# 
# Author:: jlopezn@neonline.cl 
class CustomerManagementTest < ActiveSupport::TestCase

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
		@service = BingAdsApi::CustomerManagement.new(@options)

	end
	
	
	test "truth" do
		assert_kind_of Module, BingAdsApi
	end
	
	
	test "initialize" do
		@service = BingAdsApi::CustomerManagement.new(@options)
		assert !@service.nil?, "CustomerManagement service not instantiated"
	end
	
	
	test "get accounts info" do
		response = @service.get_accounts_info
		puts response
		assert !response.nil?, "No response received"
		assert response.is_a?(Array), "No Array as response received"
		
	end
	
end
