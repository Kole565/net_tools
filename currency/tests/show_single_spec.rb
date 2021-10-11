require "rspec"

require_relative "../lib/showsingle.rb"

describe "show_single script" do
	
	it "should print ONE_DEFAULT_CURRENCY_UNLIMITED" do
		
		first_str = "USD currency list:(1 USD = )\n"

		show_single_res = show_single()
		
		expect(
			show_single_res.lines[0]
		).to eq(first_str)

		expect(
			show_single_res.lines.count
		).to be > 100

		# puts show_single_res
	end

	it "should print ONE_USD_CURRENCY_LIMITED" do
		
		first_str = "USD currency list:(1 USD = )\n"

		show_single_res = show_single(:open_curr => "USD", :limit => 3)
		
		expect(
			show_single_res.lines[0]
		).to eq(first_str)

		expect(
			show_single_res.lines.count
		).to eq(4)

	end

	it "should print ONE_RUB_CURRENCY_LIMITED" do
		
		first_str = "RUB currency list:(1 RUB = )\n"

		show_single_res = show_single(:open_curr => "RUB", :limit => 5)
		
		expect(
			show_single_res.lines[0]
		).to eq(first_str)

		expect(
			show_single_res.lines.count
		).to eq(6)
		
	end

	it "should print CURRENCY_EUR_CUSTOM_UNLIMITED" do
		
		first_str = "EUR currency list:(1 EUR = )\n"

		show_single_res = show_single(:open_curr => "EUR")
		
		expect(
			show_single_res.lines[0]
		).to eq(first_str)

		expect(
			show_single_res.lines.count
		).to be > 100
		
	end

	it "should print RUB_TO_USD_STRAIGHT" do
		
		first_str = "1 RUB is " # First 9 sym's

		show_single_res = show_single(:open_curr => "RUB", :target_curr => "USD")
		
		expect(
			show_single_res.lines[0][..8]
		).to eq(first_str)

		expect(
			show_single_res.lines.count
		).to eq(1)
		
	end

	it "should print USD_TO_RUB_STRAIGHT" do
		
		first_str = "1 USD is "

		show_single_res = show_single(:open_curr => "USD", :target_curr => "RUB")
		
		expect(
			show_single_res.lines[0][..8]
		).to eq(first_str)

		expect(
			show_single_res.lines.count
		).to eq(1)
		
	end

	it "should print EUR_TO_SEVERAL" do
		
		first_str = "EUR currency list:(1 EUR = )\n"

		show_single_res = show_single(:open_curr => "EUR", :target_curr => ["RUB", "USD"])
		
		expect(
			show_single_res.lines[0]
		).to eq(first_str)

		expect(
			show_single_res.lines.count
		).to eq(3)
		
	end

end