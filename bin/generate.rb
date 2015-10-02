#!/usr/bin/env/ruby

index = 0
stream = File.read "/dev/stdin"

stream.gsub! "\t", " "
stream.gsub! "\n", " "
stream = stream.split " "

last = "ws_start"
clast = "0"
stack = []
labels = {}
label = 0

def number? n
	for i in 0...n.length
		if (n[i].chr < '0') or (n[i].chr > '9')
			return nil
		end
	end

	return true
end

def subst astr
	str = astr.dup
	str.gsub! "@", "AT"
	str.gsub! "!", "EXC"
	str.gsub! "-", "DASH"
	str.gsub! "'", "SQUOT"
	str.gsub! '"', "DQUOT"
	str.gsub! ":", "COLON"
	str.gsub! ";", "SCOLON"
	str.gsub! ",", "COMMA"
	str.gsub! "`", "TICK"
	str.gsub! "+", "PLUS"
	str.gsub! "=", "EQUAL"
	str.gsub! "\\", "BSLASH"
	str.gsub! "/", "SLASH"
	str.gsub! ".", "DOT"
	str.gsub! "]", "RBRACK"
	str.gsub! "[", "LBRACK"
	str.gsub! "%", "PERCN"
	str.gsub! "0", "ZERO"
	str.gsub! "1", "ONE"
	str.gsub! "2", "TWO"
	str.gsub! "3", "THREE"
	str.gsub! "4", "FOUR"
	str.gsub! "<", "LT"
	str.gsub! ">", "GT"
	str.gsub! "*", "MULT"
	return str
end

def convert_to_CFA astr
	str = subst astr
	return str + "_CFA"
end

def convert_to_lbl astr
	str = subst astr
	return str + "_start"
end

def convert_to_anon astr
	str = subst astr
	return str + "_anon"
end

while index < stream.length
	begin
		case stream[index]
			when "%:"
				index += 1
				puts "#{convert_to_lbl stream[index]}:"
				puts "\tSAVE_WS #{last}"
				last = convert_to_lbl stream[index]
				puts "\tSTRING \"#{stream[index]}\", 0"
				puts "#{convert_to_CFA stream[index]}:"
				puts "\tSAVE_WS #{convert_to_CFA 'enter'}"
			when "%C:"
				index += 1
				puts "#{convert_to_lbl stream[index]}:"
				puts "\tSAVE_WS #{clast}"
				clast = convert_to_lbl stream[index]
				puts "\tSTRING \"#{stream[index]}\", 0"
				puts "#{convert_to_CFA stream[index]}:"
				puts "\tSAVE_WS #{convert_to_CFA 'enter'}"
			when "%;"
				puts "\tSAVE_WS #{convert_to_CFA 'exit'}\n"
				puts
			when "%if"
				stack.push label
				puts "\tSAVE_WS #{convert_to_CFA 'jz'}"
				puts "\tSAVE_WS label#{label}"
				label += 1
			when "%else"
				lbl = stack.pop
				puts "\tSAVE_WS #{convert_to_CFA 'jp'}"
				puts "\tSAVE_WS label#{label}"
				stack.push label
				label += 1
				puts "label#{lbl}:"
			when "%then"
				puts "label#{stack.pop}:"
			when "%lit"
				puts "\tSAVE_WS #{convert_to_CFA 'lit'}"
				index += 1
				puts "\tSAVE_WS #{convert_to_CFA stream[index]}"
			when "%variable"
				index += 1
				puts "#{convert_to_lbl stream[index]}:"
				puts "\tSAVE_WS #{last}"
				last = convert_to_lbl stream[index]
				puts "\tSTRING \"#{stream[index]}\", 0"
				puts "#{convert_to_CFA stream[index]}:"
				puts "\tSAVE_WS #{convert_to_CFA 'enter'}"
				puts "\tSAVE_WS #{convert_to_CFA 'lit'}"
				puts "\tSAVE_WS label#{label}"
				puts "\tSAVE_WS #{convert_to_CFA 'exit'}"
				puts "label#{label}:"
				puts "\tSAVE_WS 0"
				puts
				label += 1
			when "%goto"
				index += 1
				puts "\tSAVE_WS #{convert_to_CFA 'jp'}"
				lbl = labels["#{stream[index]}"]
				if not lbl
					abort "Unknown label-- #{stream[index]}"
				end
				puts "\tSAVE_WS #{lbl}"
			when "%goto-z"
				index += 1
				puts "\tSAVE_WS #{convert_to_CFA 'jz'}"
				lbl = labels["#{stream[index]}"]
				if not lbl
					abort "Unknown label-- #{stream[index]}"
				end
				puts "\tSAVE_WS #{lbl}"
			when "%goto-nz"
				index += 1
				puts "\tSAVE_WS #{convert_to_CFA 'jnz'}"
				lbl = labels["#{stream[index]}"]
				if not lbl
					puts labels
					abort "Unknown label-- #{stream[index]}"
				end
				puts "\tSAVE_WS #{lbl}"
			else	
				if stream[index][0].chr == '~'
					labels["#{stream[index][1..-1]}"] = convert_to_anon stream[index][1..-1]
					puts "#{convert_to_anon stream[index][1..-1]}:"
				elsif number? stream[index]
					puts "\tSAVE_WS #{convert_to_CFA 'lit'}"
					puts "\tSAVE_WS #{stream[index]}"
				else
					n = convert_to_CFA stream[index]
					puts "\tSAVE_WS #{n}"
				end
		end
	rescue
		abort "Got an exception while parsing the stream: #{$!}"
	end

	index += 1
end

puts "#{convert_to_lbl 'clast'}:"
puts "\tSAVE_WS #{clast}"
puts "\tSTRING \"clast\", 0"
puts "#{convert_to_CFA 'clast'}:"
puts "\tSAVE_WS #{convert_to_CFA 'enter'}"
puts "\tSAVE_WS #{convert_to_CFA 'lit'}"
puts "\tSAVE_WS label_CLAST"
puts "\tSAVE_WS #{convert_to_CFA 'exit'}"
puts "label_CLAST:"
puts "\tSAVE_WS #{convert_to_lbl 'clast'}"
puts
label += 1


puts "#{convert_to_lbl 'last'}:"
puts "\tSAVE_WS #{last}"
puts "\tSTRING \"last\", 0"
puts "#{convert_to_CFA 'last'}:"
puts "\tSAVE_WS #{convert_to_CFA 'enter'}"
puts "\tSAVE_WS #{convert_to_CFA 'lit'}"
puts "\tSAVE_WS label_LAST"
puts "\tSAVE_WS #{convert_to_CFA 'exit'}"
puts "label_LAST:"
puts "\tSAVE_WS #{convert_to_lbl 'last'}"
puts
label += 1


