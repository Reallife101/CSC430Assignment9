#Import unit tests
using Test

#----------------Data Definitions--------------
#;ExprC: Function definitions, application of functions, ifs, real, str and sym
struct LamC{T} 
	args::Vector{Char}
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

ExprC = Union{Number, Char, String, LamC, AppC, IfC}

#Values
struct ClosV{T}
	args::Vector{Char}
	body::ExprC
	env::T
end

Value = Union{Number, String, Bool}

#Environment: List of Binding
struct Binding
	name::Char
	value:: Value
end
Environment = Vector{Binding}

#-------------- Base Environment --------------
baseenv = [Binding('t', true),
			Binding('f', false)]
			# Binding("+", +),
			# Binding("-", -),
			# Binding("*", *),
			# Binding("/", /)]

#---------- Interp ---------
function interp(e::ExprC, env::Environment)
	if e isa String || e isa Number 
		return e
	elseif e isa Char
		return lookup(e, env)
	elseif e isa LamC
		return ClosV{Environment}(e.args, e.body, env)
	else e isa IfC
		return if interp(e.a, env) interp(e.b, env) else interp(e.c, env) end
	end
end

function lookup(c::Char, env::Environment)
	for b in env
		if b.name == c
			return b.value
		end
	end
	error("GIYA: char not in env")
end

#-------------- Testing ----------------
@test typeof(Binding('t', true)) == Binding
@test 3.121321 isa ExprC

#Test interp 
@test interp(1, baseenv) == 1 
@test interp("hi", baseenv) == "hi" 
@test interp(IfC{ExprC}('t', 1, 2), baseenv) == 1 
@test typeof(interp(LamC{ExprC}(['t'], 2), baseenv)) == ClosV{Environment} 

