module Agents

using Parameters
using ..FlowUnits

export Company, Supplier, Manufacturer
export Inventory_status

abstract type Company end

mutable struct Inventory_status
    on_hand::Int
    max::Int
end

"""
Something something
"""
@with_kw struct Supplier <: Company
    capacity::Dict{FlowUnit, Inventory_status}
end

@with_kw struct Manufacturer <: Company
    cap::Dict{FlowUnit, Tuple{Int, Int}}
end

@with_kw struct Distributor <: Company
    name::String = "name"
end

@with_kw struct Retailer <: Company
    name::String = "name"
end

@with_kw struct Customer <: Company # Could be a final consumer
    name::String = "name"
end

end # Module Agents
