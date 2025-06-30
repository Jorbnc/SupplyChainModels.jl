export SimpleSimulator, run!

"""
...
"""
struct SimpleSimulator{RNG<:AbstractRNG,A<:AbstractArray} <: AbstractSimulator
    rng::RNG
    horizon::Int
    #= INV::Array{Int,3} =#
    INV::A
    indices_SKU::Dict{Symbol,Int}
    N_SKUs::Int
    baz::Vector{Any} #TODO: Improve this
end

function SimpleSimulator(SC::MetaGraph; rng=Random.default_rng(), horizon=365)
    # System Inventory Initialization
    INV, indices_SKU = initialize_inventory!(SC)

    baz = []
    # Link Initialization
    for ((labelA, labelB), link) in SC.edge_data
        foo = initialize_link!(SC, code_for(SC, labelA), code_for(SC, labelB), link, horizon, indices_SKU)
        push!(baz, foo...)
    end

    return SimpleSimulator(rng, horizon, INV, indices_SKU, length(indices_SKU), baz)
end

"""
...
"""
function run!(SC::MetaGraph, sim::SimpleSimulator, vis=nothing)

    if !isnothing(vis)
        v = vis(sim)
    end

    for t in 0:sim.horizon
        for (P, SO, L) in sim.baz
            P(t, sim.INV, SO, L)
        end

        if !isnothing(vis)
            v(t, sim)
        end
    end
    #= println(v.obs) =#
end
