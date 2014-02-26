# -*- encoding : utf-8 -*-

module BingAdsApi
	
	##
	# Public:: Module to define an object as Hasheable for the SOAP requests
	# 
	# Author::  jlopezn@neonline.cl 
	module SOAPHasheable
		
		
		# Internal: Metodo custom para transformar a hash un objeto.
		# Se puede indicar si se desean las keys en formato CamelCase o underscore_case
		#
		# Author::  asaavedrab@neonline.cl
		#
		# === Parameters
		# * keys_case - indica si las keys del hash deben estar en formato 
		# ** :camelcase  - CamelCase
		# ** :underscore - underscore_case
		# 
		# === Example
		#   a=BusinessPartner.new
		#   a.to_hash
		#   # => {id => 1, name => "emol"}
		#
		# Returns:: Hash
		def to_hash(keys_case=:underscore)
			object_to_hash(self, keys_case)
		end
		
		
		# Internal: Internal method to return an object as a SOAP Request alike hash
		# If the object is an array, this methods executes object_to_hash for each item.
		# If the object is a Hash, this methods normalize the keys according to +keys_case+ and executes object_to_hash for each value
		# If the object is a String or Numeric, returns the object  
		#
		# Author::  asaavedrab@neonline.cl, jlopezn@neonline.cl
		#
		# === Parameters
		# * +object+    - object instance to be hashed
		# * +keys_case+ - specifies the hash keys case, default 'underscore'
		# ==== keys_case
		# * :camelcase  - CamelCase
		# * :underscore - underscore_case
		# 
		# === Example:
		#   a=Person.new
		#   a.to_hash(:underscore)
		#   # => {'id' => 1, 'full_name' => "John Doe"}
		#
		#   a=Person.new
		#   a.to_hash(:camelcase)
		#   # => {'Id' => 1, 'FullName' => "John Doe"}
		#
		#   a=[<Person>, <Person>, <Cat>]
		#   a.to_hash(:underscore)
		#   # => [{'id' => 1, 'full_name' => "John Doe"}, {'id' => 2, 'full_name' => "Ms Mary"}, {'id' => 3, 'name' => "Mr Whiskers", 'color' => "Gray"}]
		#
		# Returns:: Hash
		def object_to_hash(object, keys_case=:underscore)

			# Nil safe
			return nil if object.nil?
			
			# In case of hash, we only normalize the keys values
			return normalize_hash_keys(object, keys_case) if object.is_a?(Hash)
			# In case of array, we make hasheable each element
			return object.collect{ |item| object_to_hash(item, keys_case) } if object.is_a?(Array)
			# In case of number or string, this methods return the object
			return object if object.is_a?(String) || object.is_a?(Numeric)

			hash={}
			object.instance_variables.each do |var| 
				if !object.instance_variable_get(var).nil?
					value = object.instance_variable_get(var)
					hashed_value = case value.class.to_s
						when "Hash" then normalize_hash_keys(value, keys_case)
						when "Array" then value.collect{ |item| object_to_hash(item, keys_case) }
						else value
					end
					hash[get_attribute_key(var, keys_case)] = hashed_value 
				end 
			end
			return hash
		end
		
		
		# Public:: Normalize the keys of a hash with the case specified 
		# 
		# Author:: jlopexn@neonline.cl 
		# 
		# === Parameters
		# * +hash+ - Hash to be normalized
		# * +keys_case+ - :underscore or :camelcase
		# 
		# === Examples 
		#   normalize_hash_keys({:some_key => value1}, :camelcase) 
		#   # => {"SomeKey" => value1} 
		# 
		#   normalize_hash_keys({:some_key => value1}, :underscore) 
		#   # => {"some_key" => value1} 
		# 
		# Returns:: Hash
		def normalize_hash_keys(hash, keys_case)
			return hash.inject({}) { |h, (k, v)| h[get_attribute_key(k, keys_case)] = object_to_hash(v, keys_case); h }
		end
		
		
		# Internal : Helper method to determinate the key name in the hash for the SOAP request 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# === Parameters
		# * attribute - the attribute name
		# * keys_case - defines the case for the attribute name. 
		# ==== keys_case
		# * :camelcase  - CamelCase
		# * :underscore - underscore_case
		# 
		# === Examples 
		#   get_attribute_key("attribute_name", :underscore) 
		#   # => "attribute_name" 
		# 
		#   get_attribute_key("name", :camelcase) 
		#   # => "AttributeName" 
		# 
		# Returns:: String with the attribute name for the key in the hash
		def get_attribute_key(attribute, keys_case = :underscore)
			if keys_case == :underscore
				return attribute.to_s.delete("@").underscore
			elsif keys_case == :camelcase
				return attribute.to_s.delete("@").camelcase
			end
		end
		
		
		# Internal : Returns a DateTime as a hash for SOAP requests 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# === Parameters
		# * date - DateTime to be hashed
		# * keys_case - defines the case for keys in the hash
		# ==== keys_case
		# * :camelcase  - CamelCase
		# * :underscore - underscore_case
		# 
		# Returns:: Hash with the :year, :month, :day keys
		def date_to_hash(date, keys_case)
			{
				get_attribute_key("day", keys_case)   => date.day,
				get_attribute_key("month", keys_case) => date.month,
				get_attribute_key("year", keys_case)  => date.year
			}
		end
		
	end
	
end