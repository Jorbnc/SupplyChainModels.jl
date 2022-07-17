module Agents

using Parameters
# using Random, Distributions
using ..FlowUnits

export Company, Supplier, Manufacturer, Retailer, Customer
export Inventory

# ============================================================

@with_kw mutable struct Inventory
    on_hand::Int = 0
    backorder::Int = 0
    pipeline::Int = 0
    max_cap::Int = 0
    demand::Int = 0 # IRL, it could exceed max_cap
end

@with_kw mutable struct Inventory_supplier
    on_hand::Int = 0
    backorder::Int = 0
    pipeline::Int = 0
    max_cap::Int = 0
end

mutable struct Position
    longitude::Float64 # The type will depend on the coordinate system
    latitute::Float64
end

# ============================================================

abstract type Company end

@with_kw struct Supplier <: Company
    inventory_status::Dict{FlowUnit, Inventory_supplier}
end

@with_kw struct Manufacturer <: Company
    inventory_status::Dict{FlowUnit, Inventory}
end

@with_kw struct Distributor <: Company
    inventory_status::Dict{FlowUnit, Inventory}
end

@with_kw struct Retailer <: Company
    inventory_status::Dict{FlowUnit, Inventory}
end

@with_kw struct Customer <: Company # Could be a final consumer
    inventory_status::Dict{FlowUnit, Inventory}
end

end # Module Agents