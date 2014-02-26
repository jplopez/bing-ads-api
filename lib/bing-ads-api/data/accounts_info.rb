# -*- encoding : utf-8 -*-

module BingAdsApi
	
	# Public : Define an account info  
	# 
	# Author:: jlopezn@neonline.cl 
	# 
	# Examples 
	#   campaign = BingAdsApi::AccountInfo.new(
	#     :account_life_cycle_status => BingAdsApi::AccountsInfo::DRAFT 
	#     :name => "Account Name",
	#     :number => 1234567,
	#     :pause_reason => "1")
	#   # => <BingAdsApi::AccountInfo> 
	class AccountInfo < BingAdsApi::DataObject
		include BingAdsApi::AccountLifeCycleStatuses
	
		attr_accessor :id, :account_life_cycle_status, :name, :number, :pause_reason
	
		# Public:: Returns true if the account is in status active 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# Returns:: boolean
		def active?
			return account_life_cycle_status == ACTIVE 
		end


		# Public:: Returns true if the account is in status draft 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# Returns:: boolean
		def draft?
			return account_life_cycle_status == DRAFT 
		end


		# Public:: Returns true if the account is in status inactive 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# Returns:: boolean
		def inactive?
			return account_life_cycle_status == INACTIVE 
		end


		# Public:: Returns true if the account is in status pause 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# Returns:: boolean
		def pause?
			return account_life_cycle_status == PAUSE 
		end


		# Public:: Returns true if the account is in status pending 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# Returns:: boolean
		def pending?
			return account_life_cycle_status == PENDING 
		end

	end

end