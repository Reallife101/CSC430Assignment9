#Import unit tests
using Test

#----------------Data Definitions--------------
#;ExprC: Function definitions, application of functions, ifs, real, str and sym
struct LamC{T} 
	args::Vector{String}
	body::T
end

struct AppC{T} 
	fun::T
	arg::Vector{T}
end

struct IfC{T}
	a::T
	b::T
	c::T
end

ExprC = Union{Number, Bool, String, LamC, AppC, IfC}

#Values
Value = Union{Number, String, Bool}

#Environment: List of Binding
struct Binding
	name::String
	value:: Value
end
Environment = Vector{Binding}

#-------------- Base Environment --------------
baseenv = [Binding("true", true),
			Binding("false", false)]
			# Binding("+", +),
			# Binding("-", -),
			# Binding("*", *),
			# Binding("/", /)]

#---------- Interp ---------
function interp(e::ExprC, env::Environment)
	if e isa String || e isa Number 
		return e
	else e isa IfC
		return if e.a e.b else e.c end
	end
end

#-------------- Testing ----------------
@test typeof(Binding("true", true)) == Binding
@test 3.121321 isa ExprC

#Test interp 
@test interp(1, baseenv) == 1 
@test interp("hi", baseenv) == "hi" 
@test interp(IfC{ExprC}(true, 1, 2), baseenv) == 1 

