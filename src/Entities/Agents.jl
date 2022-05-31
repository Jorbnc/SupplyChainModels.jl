module Agents

using Parameters # Allows using @with_kw for optional/default fields in structs
# --------------------------------------------------------------------------------
using ..FlowUnits

export Supplier

abstract type Company end

@with_kw struct Supplier <: Company
    name::Union{Nothing, String} = nothing
    cap::Dict{FlowUnit, Tuple{Int, Int}}
    size::Int
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
