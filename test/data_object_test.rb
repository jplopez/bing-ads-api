# -*- encoding : utf-8 -*-
require 'test_helper'

# Public : Test Case for Data Object instances 
# 
# Author jlopezn@neonline.cl 
class DataObjectTest < ActiveSupport::TestCase

	test "truth" do
		assert_kind_of Module, BingAdsApi
	end
	
	test "to_hash" do
		
		camp = BingAdsApi::Campaign.new(
			:budget_type => "DailyBudgetStandard", 
			:conversion_tracking_enabled => "false",
			:daily_budget => 2000,
			:daylight_saving => "false",
			:description => "Some Campaign",
			:monthly_budget => 5400,
			:name => "Some campaign",
			:status => "Paused",
			:time_zone => "Santiago")
		
		h = camp.to_hash

		assert h.is_a?(Hash), "to_hash doesn't return a hash"
		assert !h.nil? , "No hash was received"
		
		assert h["budget_type"]==camp.budget_type, "budget_type doesn't match"
		assert h["conversion_tracking_enabled"]==camp.conversion_tracking_enabled, 
			"conversion_tracking_enabled doesn't match"
		assert h["daily_budget"]==camp.daily_budget, "daily_budget doesn't match"
		assert h["daylight_saving"]==camp.daylight_saving, "daylight_saving doesn't match"
		assert h["description"]==camp.description, "description doesn't match"
		assert h["monthly_budget"]==camp.monthly_budget, "monthly_budget doesn't match"
		assert h["name"]==camp.name, "name doesn't match"
		assert h["status"]==camp.status, "status doesn't match"
		assert h["time_zone"]==camp.time_zone, "time_zone doesn't match"
		
	end



end
