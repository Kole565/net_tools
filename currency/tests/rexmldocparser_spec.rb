require "rspec"

require_relative "../lib/currencygetter.rb"
require_relative "../lib/rexmldocparser.rb"

describe "RexmlDocParser" do

	it "should PARSE_USD" do

		data = CurrencyGetter.get_doc("http://www.floatrates.com/daily/usd.xml")

		compare_hash = {}
		compare_hash["EUR"] = [1, 0.85]
		compare_hash["GBP"] = [1, 0.73]
		compare_hash["CAD"] = [1, 1.26]


		key_data = RexmlDocParser.parse(data).keys
		
		for key in compare_hash.keys
			expect(
				key_data
			).to include(key)
		end

		expect(
			RexmlDocParser.parse(data).values[0]
		).to include(1)

	end

	it "should PARSE_RUB" do

		data = CurrencyGetter.get_doc("http://www.floatrates.com/daily/rub.xml")

		compare_hash = {}
		compare_hash["EUR"] = [1, 42]
		compare_hash["GBP"] = [1, 42]
		compare_hash["CAD"] = [1, 42]


		key_data = RexmlDocParser.parse(data).keys
		
		for key in compare_hash.keys
			expect(
				key_data
			).to include(key)
		end

		expect(
			RexmlDocParser.parse(data).values[0]
		).to include(1)

	end

	it "should return USD_PARSED_VIEW" do

		data = CurrencyGetter.get_doc("http://www.floatrates.com/daily/usd.xml")

		parsed = RexmlDocParser.parse(data)

		visual = RexmlDocParser.view(parsed)

		first_str = "USD currency list:(1 USD = )\n"

		expect(
			visual.lines[0]
		).to eq(first_str)

	end

	
	
end