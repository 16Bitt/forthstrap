#!/usr/bin/env ruby

$block = 0x0302

puts "( This file generated for nofs.forth )\n"

ARGV.each do |filename|
	$stderr.puts "Generating listing for #{filename}:"
	sz = File.size filename
	blks = (sz / 512)
	if (sz % 512) != 0
		blks += 1
	end
	$stderr.puts "\t* #{sz} bytes"
	$stderr.puts "\t* #{blks} block(s)"
	puts ": #{filename} h #{$block.to_s(16)} #{blks} ;"
	$block += blks
end

puts ": dir"
ARGV.each do |filename|
	puts "\" #{filename} \" .s"
end
puts ";"
