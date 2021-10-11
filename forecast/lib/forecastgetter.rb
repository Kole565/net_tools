require "rexml/document"

require_relative "../../lib/internetimporter.rb"

class ForecastGetter < InternetImporter
	# Static class get, parse weather xml from site

	def self.get_page_body(link)
		uri = uri_parse(link)

		get_response(uri).body
	end

	def self.parse(page_body)
		parsed = []
		# "year_month_day_hour" => 
		# 	{
		#		"cloudiness" => Int
		#
		#		"pressure_max" => Int
		#		"pressure_min" => Int
		#
		#		"temperature_max" => String
		#		"temperature_min" => String
		#
		# 		"wind_direction" => Int
		# 		"wind_power_max" => Int
		# 		"wind_power_min" => Int
		# 	}
		#
		# "2021_05_05_05" =>
		# 	{
		#		"cloudiness" => 3
		#
		#		"pressure_max" => 800
		#		"pressure_min" => 777
		#
		#		"temperature_max" => "42"
		#		"temperature_min" => "-42"
		#
		# 		"wind_direction" => 5
		# 		"wind_power_max" => 2
		# 		"wind_power_min" => 0
		# 	}

		doc = REXML::Document.new(page_body)

		root_els = doc.root.elements
		town = root_els.first.elements.first
		forecasts = town.elements

		for forecast in forecasts
			temp = forecast_parse(forecast)

			temp_forecast = {}
			temp_forecast[temp[0]] = temp[1]
			
			parsed << temp_forecast
		end

		parsed
	end

	def self.forecast_parse(forecast)
		output = []

		key = ""
		data = {}

		key += "#{forecast.attributes["year"]}_"
		key += "#{forecast.attributes["month"]}_"
		key += "#{forecast.attributes["day"]}_"
		key += "#{forecast.attributes["hour"]}"
		
		properties = forecast.elements
		data["cloudiness"] = properties["PHENOMENA"].attributes["cloudiness"].to_i

		data["pressure_max"] = properties["PRESSURE"].attributes["max"].to_i
		data["pressure_min"] = properties["PRESSURE"].attributes["min"].to_i

		data["temperature_max"] = properties["TEMPERATURE"].attributes["max"]
		data["temperature_min"] = properties["TEMPERATURE"].attributes["min"]

		data["wind_direction"] = properties["WIND"].attributes["dirrection"].to_i
		data["wind_power_max"] = properties["WIND"].attributes["max"].to_i
		data["wind_power_min"] = properties["WIND"].attributes["min"].to_i
		
		output << key
		output << data

		output
	end

end