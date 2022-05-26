module Agents

# --------------------------------------------------------------------------------

# maybe I should import an existing package for this...

# gotta import Functions/Actions.jl
# (make a quick diagram for import/using logic and add it to the Julia cheatsheet)

abstract type Company end

struct Manufacturer <: Company
    name::Union{Missing, String}
    suppliers::Array{Union{Missing, Company}}
    customers::Array{Union{Missing, Company}}
end

end # Module Agents
