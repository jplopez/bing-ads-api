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
		#   Se puede indicar si se desean las keys en formato CamelCase o underscore_case
		#
		# Author: asaavedrab@neonline.cl
		#
		# keys - indica si las keys del hash deben estar en formato 
		#        CamelCase (:camelcase) o underscore_case (:underscore)
		# 
		# Example:
		# 
		#   a=BusinessPartner.new
		#   a.to_hash
		#   # => {id => 1, name => "emol"}
		#
		# Returns Hash.
		def to_hash(keys = :underscore)
			hash={}
			self.instance_variables.each do |var| 
				if !self.instance_variable_get(var).nil?
					hash[get_attribute_key(var, keys)] = self.instance_variable_get(var)
				end 
			end
			return hash
		end


		def to_s
			to_hash.to_s
		end

		private
			
			# Public : Helper method to determinate the key name in the hash for the SOAP request 
			# 
			# Author jlopezn@neonline.cl 
			# 
			# attribute - the attribute name
			# keys      - defines the case for the attribute name. 
			#   Expected values are :camelcase y :underscore
			# 
			# Examples 
			#   get_attribute_key("attribute_name", :underscore) 
			#   # => "attribute_name" 
			# 
			#   get_attribute_key("name", :camelcase) 
			#   # => "AttributeName" 
			# 
			# Returns String with the attribute name for the key in the hash
			def get_attribute_key(attribute, keys = :underscore)
				if keys == :underscore
					return attribute.to_s.delete("@").underscore
				elsif keys == :camelcase
					return attribute.to_s.delete("@").camelcase
				end
			end
			
			
			# Public : Returns a DateTime as a hash for SOAP requests 
			# 
			# Author jlopezn@neonline.cl 
			# 
			# date - DateTime to be hashed
			# 
			# Returns Hash with the :year, :month, :day keys
			def date_to_hash(date, keys)
				{
					get_attribute_key("day", keys)   => date.day,
					get_attribute_key("month", keys) => date.month,
					get_attribute_key("year", keys)  => date.year
				}
			end
	end
end