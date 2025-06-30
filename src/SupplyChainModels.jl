module SupplyChainModels

using Reexport
using MetaGraphsNext, MetaGraphsNext.Graphs
using Random
using Accessors

@reexport using Distributions

export LeadTime

"""
...
"""
mutable struct LeadTime{D<:UnivariateDistribution}
    𝒟::D
    counter::Int
    active::Bool
end

LeadTime(𝒟::UnivariateDistribution) = LeadTime(𝒟, rand(𝒟) + 1, false)
LeadTime(t::Int) = LeadTime(Constant(t), t + 1, false)

function (L::LeadTime)()
    L.counter -= 1
    if L.counter == 0
        L.counter = rand(L.𝒟) + 1
        return true
    end
    return false
end

include("Structures/Structures.jl")
include("Actions/Actions.jl")
include("Policies/Policies.jl")
include("Agents/Agents.jl")
include("Simulation/Simulation.jl")

end # module
