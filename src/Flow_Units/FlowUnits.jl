module FlowUnits

using Parameters

export FlowUnit, Raw, Component, WIP, Product

abstract type FlowUnit end

@with_kw struct Raw <: FlowUnit # Immutabe object!
    days::Int = 365 # Immutable perishability!
end

struct Component <: FlowUnit
    #
end

struct WIP <: FlowUnit
    #
end

struct Product <: FlowUnit
    #
end

end # Module FlowUnits