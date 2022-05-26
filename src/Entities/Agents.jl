module Agents

using Parameters # Allows using @with_kw for optional/default fields in structs
# --------------------------------------------------------------------------------

# maybe I should import an existing package for node-like structures
# gotta import Functions/Actions.jl

abstract type Company end

@with_kw struct Supplier <: Company
    name::Union{Nothing, String} = nothing
    # actions::Array{Union{Missing, Actions}} # See <.../Functions>
end

@with_kw struct Manufacturer <: Company
    name::Union{Nothing, String} = nothing
    # actions::Array{Union{Missing, Actions}}
end

@with_kw struct Distributor <: Company
    name::Union{Nothing, String} = nothing
    # actions::Array{Union{Missing, Actions}}
end

@with_kw struct Retailer <: Company
    name::Union{Nothing, String} = nothing
    # actions::Array{Union{Missing, Actions}}
end

@with_kw struct Customer <: Company # Could be a final consumer
    name::Union{Nothing, String} = nothing
    # actions::Array{Union{Missing, Actions}}
end

end # Module Agents
