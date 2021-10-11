require_relative "./currencygetter.rb"
require_relative "./rexmldocparser.rb"

# Print internet updated valute list
def show_single(options = {})

	if options[:open_curr] != nil
		link = "http://www.floatrates.com/daily/#{options[:open_curr].downcase}.xml"
	else
		link = "http://www.floatrates.com/daily/usd.xml"
	end
	
	doc = CurrencyGetter.get_doc(link)

	parsed = RexmlDocParser.parse(doc)

	visual = RexmlDocParser.view(parsed, options)

	if options[:limit] != nil
		visual = visual.split("\n")[..options[:limit]].join("\n")
	end

	visual

end