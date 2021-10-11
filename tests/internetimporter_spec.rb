require "rspec"

require_relative "../lib/internetimporter.rb"

describe "InternetImporter" do
	
	it "should return URI_PARSE" do
		
		expect(
			InternetImporter.uri_parse("https://www.google.com/").class.name
		).to eq("URI::HTTPS")

	end

	it "should return HTTPS_RESPONSE" do
		
		uri = InternetImporter.uri_parse("https://www.google.com/")

		expect(
			InternetImporter.get_response(uri).code
		).to eq("200")

	end

	it "should check INTERNET_CONNECTION" do
		
		uri = InternetImporter.uri_parse("https://www.google.com/")

		expect(
			InternetImporter.get_response(uri).code
		).to eq("200")

	end

	it "should check GOOGLE_AVALIABLE" do
		
		uri = InternetImporter.uri_parse("https://www.google.com/")

		expect(
			InternetImporter.get_response(uri).code
		).to eq("200")

	end
	
end