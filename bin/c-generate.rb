#!/usr/bin/env ruby

$last = "last_start"

def out function, name, size_in, size_out
	output = <<-ENDOFGEN
		EXTERNAL_C_DEF #{function}
		#{name}_start:
			SAVE_WS #{$last}
			STRING "#{name}", 0
		#{name}_CFA:
			SAVE_WS #{name}_BEGIN
		#{name}_BEGIN:
			SAVE_FORTH_#{size_in}
			SAVE_REG_STATE
			SAVE_STACK
			PUSH_FORTH_#{size_in}
			C_CALL #{function}
			SAVE_#{size_out}
			RESTORE_STACK
			RESTORE_REG_STATE
			GO_NEXT
	ENDOFGEN
	$last = "#{name}_start"
	return output
end

ARGV.each do |file|
	$stderr.puts "Making C bindings for #{file}"
	file = File.open file, 'r'
	file.each do |line|
		if line.length <= 3
			next
		end

		if line[0...3] == "//F"
			val = line.chomp.split ' '
			$stderr.puts "\t* Making binding for #{val[1]}()"
			puts out(val[1], val[2], val[3], val[4])
		end
	end
end

$stderr.puts "Wrapping up..."
puts <<-ENDOFGEN
	unix_runtime_init:
		STORE_VALUE_AT label_LAST, #{$last}
		RETURN_FROM_FUNCTION
ENDOFGEN
