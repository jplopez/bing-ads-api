# -*- encoding : utf-8 -*-

module BingAdsApi

	# Public : Generic exception thrown by service classes in BingAdsApi. 
	#   Exception of this kind wrap an AdApiFaultDetail or ApiFaultDetail instance
	#   to look over the specific details of the SOAP request fault.
	# 
	# Author jlopezn@neonline.cl 
	# 
	# Example
	#   
	#
	#
	#
	class ApiException < Exception
		
		attr_accessor :fault_object
		
		# Public : Constructor. Based on the default Exception constructor, 
		# adds the fault_object instance, that can be an ApiFaultDetail or 
		# AdApiFaultDetail instance 
		# 
		# === Parameters
		# * fault_object - AdApiFaultDetail or ApiFaultDetail instance
		# * msg - optional message
		#
		# Author jlopezn@neonline.cl 
		def initialize(fault_object, msg=nil)
			super(msg)
			self.fault_object = fault_object
		end
		
		
		# Public : Specified to string method 
		# 
		# Author jlopezn@neonline.cl 
		def to_s
			super.to_s + " - " + fault_object.to_s
		end
	end
end