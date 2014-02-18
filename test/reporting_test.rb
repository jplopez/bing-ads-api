# -*- encoding : utf-8 -*-
require 'test_helper'

# Public : Test case for Reporting services 
# 
# Author jlopezn@neonline.cl 
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
	
end
