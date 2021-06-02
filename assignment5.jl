#----------------Data Definitions--------------

struct Binding
				name
				value
			end

struct IfC
           a
           b
           c
       end
#-------------- Base Environment --------------
base-env = [Binding("true", true),
			Binding("false", false),
			Binding("+", +),
			Binding("-", -),
			Binding("*", *),
			Binding("/", /)]

#-------------- Testing ----------------

binding1 =  Binding("true", true)
print(typeof(binding1))