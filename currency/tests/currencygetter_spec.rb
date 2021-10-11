require "rspec"

require_relative "../lib/currencygetter.rb"

describe "CurrencyGetter" do

	it "should GET_DOC" do

		expect(
			CurrencyGetter.get_doc("http://www.floatrates.com/daily/usd.xml").class.name
		).to eq("REXML::Document")

	end
		
end