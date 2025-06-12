struct TimeSimulator{RNG<:AbstractRNG} <: AbstractSimulator
    rng::RNG
    T::Int
end

function TimeSimulator(; rng=Random.default_rng(), T=365)
    return TimeSimulator(rng, T)
end

"""
Time Simulation
"""
function simulate!(sc::MetaGraph, simulator::TimeSimulator)
    t = 1

    generate_policies!(sc)

    stocks_1 = Int[]
    stocks_2 = Int[]

    while t < simulator.T

        # Edge Iteration
        for ((node_label_1, node_label_2), link) in sc.edge_data
            activate_link!(sc[node_label_1], sc[node_label_2], link, t)
        end

        # Supplier Iteration
        for (node_label, (node_code, node)) in sc.vertex_properties
            activate_node!(node, t)
        end

        push!(stocks_1, sc[:Store].stock[1])
        push!(stocks_2, sc[:Store].stock[2])

        t += 1
    end
    return stocks_1, stocks_2
end
