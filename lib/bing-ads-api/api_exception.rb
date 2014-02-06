# -*- encoding : utf-8 -*-

module BingAdsApi

	class ApiException < Exception
		
		attr_accessor :fault_object
		
		# Public : Constructor. Based on the default Exception constructor, 
		#   adds the fault_object instance, that can be an ApiFaultDetail or 
		#   AdApiFaultDetail instance 
		# 
		# fault_object - AdApiFaultDetail or ApiFaultDetail instance
		# msg - optional message
		#
		# Author jlopezn@neonline.cl 
		def initialize(fault_object, msg=nil)
			super(msg)
			self.fault_object = fault_object
		end
		
		
		def to_s
			super.to_s + " - " + fault_object.to_s 
		end
	end
end