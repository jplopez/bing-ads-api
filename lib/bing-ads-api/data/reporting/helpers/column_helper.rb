# -*- encoding : utf-8 -*-

module BingAdsApi::Helpers
	
	##
	# Public : Utility module 
	# 
	# Author:: jlopezn@neonline.cl 
	# 
	module ColumnHelper

		# Internal : Validates the specified columns at the ReporRequest initialization
		# At the first invalid column detected this method raises Exception.
		# If all column values are ok, this method returns true 
		# Valid columns are validated against COLUMNS constant
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# valid_columns - Hash with the valid names and values for columns
		# columns - Hash with the columns specified in the initialization
		# 
		# Returns:: true if all columns are ok
		# Raises:: Exception at the first invalid column detected
		def valid_columns(valid_columns, columns)
			columns.each do |col|

				if col.is_a?(String)
					if !valid_columns.value?(col)
						raise Exception.new("Invalid column value '#{col}'")
					end 
				elsif col.is_a?(Symbol)
					if !valid_columns.key?(col.to_s)
						raise Exception.new("Invalid column name '#{col}'")
					end
				end
			end
			return true
		end


		# Public : Return the columns attribute of the ReportRequest as a valid Hash for SOAP requests 
		# 
		# Author:: jlopezn@neonline.cl 
		# 
		# keys_case - specifies the keys_case for the hash: :underscore or :camelcase
		# 
		# Returns:: Hash
		def columns_to_hash(valid_columns, columns, keys_case=:underscore)
			raise Exception.new("Invalid time value: nil") if columns.nil?
			
			key = self.class.to_s.demodulize.gsub(/ReportRequest/, 'ReportColumn')
			return { key => 
					columns.map do |col|
						if col.is_a?(String)
							col
						elsif col.is_a?(Symbol)
							valid_columns[col.to_s]
						end
					end
				}
		end
		
		
	end
end