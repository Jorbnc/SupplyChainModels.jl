module FlowUnits

abstract type FlowUnit end

struct Raw <: FlowUnit
    #
end

struct Component <: FlowUnit
    #
end

struct Wip <: FlowUnit
    #
end

end # Module FlowUnits