export SimpleSimulator, run!

"""
...
"""
struct SimpleSimulator{A<:AbstractArray} <: AbstractSimulator
    horizon::Int
    INV::A
    indices_SKU::Dict{Symbol,Int}
    N_SKUs::Int
    policies::Vector{Any} #TODO: Rename
end

function SimpleSimulator(SC::MetaGraph; horizon=365)
    # System Inventory Initialization
    INV, indices_SKU = initialize_inventory!(SC)

    policies = []
    # Link Initialization
    for ((labelA, labelB), link) in SC.edge_data
        ps = initialize_link!(SC, code_for(SC, labelA), code_for(SC, labelB), link, horizon, indices_SKU)
        push!(policies, ps...)
    end

    return SimpleSimulator(horizon, INV, indices_SKU, length(indices_SKU), policies)
end

"""
...
"""
function run!(SC::MetaGraph, sim::SimpleSimulator, vis=nothing)
    if !isnothing(vis)
        v = vis(sim)
    end

    for t in 0:sim.horizon
        for (P, SO, L) in sim.policies
            P(t, sim.INV, SO, L)
        end

        if !isnothing(vis)
            v(t, sim)
        end
    end
end
