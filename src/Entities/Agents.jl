module Agents

using Parameters
using ..FlowUnits

export Company, Supplier, Manufacturer

abstract type Company end

@with_kw struct Supplier <: Company
    cap::Dict{FlowUnit, Tuple{Int, Int}} # Common
end

@with_kw struct Manufacturer <: Company
    cap::Dict{FlowUnit, Tuple{Int, Int}} # Common
end

@with_kw struct Distributor <: Company
    name::String
    # actions::Array{Union{Missing, Actions}}
end

@with_kw struct Retailer <: Company
    name::String
    # actions::Array{Union{Missing, Actions}}
end

@with_kw struct Customer <: Company # Could be a final consumer
    name::String
    # actions::Array{Union{Missing, Actions}}
end

end # Module Agents
