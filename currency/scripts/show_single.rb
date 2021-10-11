require "optparse"

require_relative "../lib/showsingle.rb"

options = {}

OptionParser.new do | opts |
	# If use like script - get options and call show_single
	opts.banner = "Usage show_single script"

	opts.on("-h", "--help", "Print help") do
		puts opts
		exit
	end

	opts.on("-o", "--open_curr OPEN_CURR", String, "Specify what's valute from") do | open_curr |
		options[:open_curr] = open_curr
	end

	opts.on("-t", "--target_curr TARGET_CURR", String, "Specify what's valute to (can be several)") do | target_curr |
		
		if options[:target_curr].nil?
			options[:target_curr] = []
		end

		options[:target_curr] << target_curr
	end

	opts.on("-l", "--limit LIMIT", Integer, "Specify how many transition you need (if you set all)") do | limit |
		options[:limit] = limit
	end

	opts.on("-f", "--file FILENAME", String, "File in data/output folder where result contains (log.txt for example)") do | file_name |
		options[:file_name] = file_name
	end

	opts.on("-I", "", "For RSPEC tests") do | value |
		options[:test] = value
	end
	
end.parse!

# puts options


if options[:file_name].nil?
	show_single(options) # Single means - one start valute for time
else
	current_dir = File.dirname(__FILE__)
	path = "#{current_dir}/../data/output/#{options[:file_name]}"

	data_to_write = show_single(options)

	file = File.open(path, "w")
	file.write(data_to_write)
	file.close
end