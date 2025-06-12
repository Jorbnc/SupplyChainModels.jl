module FlowUnits

using Parameters

export FlowUnit, Raw, Component, WIP, Product

abstract type FlowUnit end

@with_kw struct Raw <: FlowUnit # Immutabe object!
    # days::Int = 365 # Immutable perishability!
    cost::Float64 = 0.00
    price::Float64 = 0.00
end

struct Component <: FlowUnit
    #
end

struct WIP <: FlowUnit
    #
end

@with_kw struct Product <: FlowUnit
    # days::Int = 365
    cost::Float64 = 0.00
    price::Float64 = 0.00
end

end # Module FlowUnits
