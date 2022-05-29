module FlowUnits

export Raw, Component, WIP, Product

abstract type FlowUnit end

struct Raw <: FlowUnit
    days::Int # Test
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