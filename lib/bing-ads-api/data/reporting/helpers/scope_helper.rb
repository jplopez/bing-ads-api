# -*- encoding : utf-8 -*-

module BingAdsApi::Helpers
	
	##
	# Public : Utility module for scope attribute in +ReportRequest+ derived classes
	# 
	# Author:: jlopezn@neonline.cl 
	# 
	module ScopeHelper
		
		include BingAdsApi::SOAPHasheable
		
		
		# Valid filters values for each known criteria
		FILTERS_CRITERIA = BingAdsApi::Config.instance.
			reporting_constants['filters']
		
		
		# Internal : Validates the filter attribute at the ReporRequest initialization
		# At the first invalid filter criteria or value detected this method raises Exception.
		# If all filter criteria and values are ok, this method returns true 
		# Valid filter criteria are validated against FILTERS_CRITERIA constant
		# Valid filter values are validated against FILTERS constant
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# === Parameters
		# valid_filters - Hash with the set of valid filter values
		# filter - Hash with the filter criteria and values
		# 
		# Returns:: true if filter is valid
		# 
		# Raises:: Exception at the first invalid filter criteria o value
		def valid_scope(valid_scopes, scope)
		end
		
		
		# Public : Returns the filter attribute as a Hash to SOAP requests 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# filter - Hash with the filter values
		# 
		# Returns:: Hash
		def scope_to_hash(keys_case=:undescore)
		end


	end
end