module SupplyChainModels

using Reexport

# Order of included modules is important
include("Flow_Units/FlowUnits.jl") # Doesn't not depend on any module (yet)
include("Entities/Agents.jl") # Depenens on FlowUnits
include("Actions/Source.jl") # Depends on Agents, FlowUnits

@reexport using .FlowUnits
@reexport using .Agents
@reexport using .Source

end # Module