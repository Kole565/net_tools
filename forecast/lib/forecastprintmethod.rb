def print_several_forecasts(forecasts, options)

	if !options[:file_name].nil?
		puts "Date format - year_month_day_hour"
		puts "Town can be changed only in code"
		puts "Thanks for using forecast script 1.0"
		puts
	end
	
	for forecast in forecasts[..options[:limit] - 1]

		for date, value in forecast
			puts "Forecast for Onega: (#{date})"
			print_forecast(value)
			puts 
		end
		
	end

end

def print_forecast(base)
	
	for param in base.keys
		puts parse_param(param, base)		
	end

end

def parse_param(param, base)
	
	if param.split("_").count > 1 # Complex name
		
		capitalize_param = param.split "_"
		capitalize_param = capitalize_param.map(&:capitalize)
		capitalize_param = capitalize_param.join(" ")

		return "\t#{capitalize_param}: #{base[param]}"
	else
		return "\t#{param.capitalize}: #{base[param]}"
	end

end