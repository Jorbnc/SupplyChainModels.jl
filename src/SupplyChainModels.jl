module SupplyChainModels

using Reexport
@reexport using Parameters
@reexport using DataFramesMeta
@reexport using GLMakie, GraphMakie, NetworkLayout, LayeredLayouts
@reexport using Graphs, MetaGraphs

include("Structures/Chains.jl")
include("Visuals/NetworkPlots.jl")
include("Visuals/ThroughputPlots.jl")

# Order of included modules is important
include("Flow_Units/FlowUnits.jl") # Doesn't depend on any module (yet)
include("Entities/Agents.jl") # Depends on FlowUnits
include("Actions/Source.jl") # Depends on Agents, FlowUnits

@reexport using .FlowUnits
@reexport using .Agents
@reexport using .Source

end # Module