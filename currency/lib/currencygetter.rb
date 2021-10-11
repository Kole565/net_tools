require "rexml/document"

require_relative "../../lib/internetimporter.rb"

class CurrencyGetter < InternetImporter
	# Get, return currency doc
	# Static

	def self.get_doc(link)
		# Using InternetImporter for response, create REXML doc
		begin
			uri = uri_parse link

			response = get_response uri
			
			REXML::Document.new(response.body)
		rescue SocketError
			raise "Link #{link} is broken"
		end
		
	end
end