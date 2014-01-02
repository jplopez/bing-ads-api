# -*- encoding : utf-8 -*-

module BingAdsApi
	
	# Public : Base Class to define Bing API data objects
	#   Do not use this class directly, use any of the derived classes 
	# 
	# Author jlopezn@neonline.cl 
	# 
	class DataObject
		
		# Public : Constructor in a ActiveRecord style, with a hash of attributes as input 
		# 
		# Author jlopezn@neonline.cl 
		# 
		# attributes - Hash with the objects attributes
		def initialize(attributes={})
			attributes.each { |key, val| send("#{key}=", val) if respond_to?("#{key}=") }
		end
		
		
		# Internal: Metodo custom para transformar a hash un objeto.
		#
		# Author: asaavedrab@neonline.cl
		#
		# Example:
		#
		# 	 a=BusinessPartner.new
		# 	 a.to_hash
		# 	 #	=> {id => 1, name => "emol"}
		#
		# Returns Hash.		
		def to_hash
			hash={}
			self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }
			return hash
		end
	end
end