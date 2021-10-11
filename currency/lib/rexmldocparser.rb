require "rexml/document"

class RexmlDocParser
	# Parse data from doc
	# For currency only

	def self.parse(data)
		parsed = {}
		# Parsed: (When USD = base)
		# base(RWF) => [valueUSD(1), valueRWF(1000), "USD"]
		# "RWF" => [1, 1000, "USD"]
		# "GYD" => [1, 200, "USD"]
		
		data.root.elements.each("item") do | item |
			
			parsed[item.elements["targetCurrency"].text] = [
				1, item.elements["exchangeRate"].text, item.elements["baseCurrency"].text
			]

		end

		parsed
	end

	def self.view(data, options = {})
		# Need parsed data
		visual = ""

		case options[:mode]
		when "single"
			visual = view_single(data, options)
		when "multi"
			# visual = view_multi(data)
			return
		else
			visual = view_single(data, options)
		end

		visual
	end

	def self.view_single(data, options = {})
		# Return string with one currency (USD => others for example)
		
		visual = ""

		# Header
		if options[:target_curr] != nil
			transitions_array = []

			if !options[:target_curr].kind_of?(Array)
				transitions_array << options[:target_curr]
			else
				transitions_array = options[:target_curr]
			end

			transitions_array.map!(&:upcase)
			
			if transitions_array.count > 1
				
				visual += "#{data.first[1][2]} currency list:(1 #{data.first[1][2]} = )\n"
			
				data.keys.each_with_index do | target, index |
					visual += "\t#{data[data.keys[index]][1]} #{target}\n" if transitions_array.include?(target.upcase)
				end
				
			else
				visual += "1 #{data.first[1][2]} is #{data[transitions_array.first.upcase][1]} #{transitions_array.first}"
			end
			
		else
			visual += "#{data.first[1][2]} currency list:(1 #{data.first[1][2]} = )\n"
			
			data.keys.each_with_index do | target, index |
				visual += "\t#{data[data.keys[index]][1]} #{target}\n"
			end
		end

		visual
	end

end