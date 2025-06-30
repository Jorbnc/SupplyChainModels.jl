"""
...
"""
get_outedges(SC::MetaGraph, codeA::Int) = (
    getindex(SC, label_for(SC, codeA), label_for(SC, codeB)) for codeB in outneighbors(SC, codeA)
)

"""
Get total expected demand for a particular node and SKU
"""
function total_expected_demand(SC::MetaGraph, node_code::Int, SKU::Symbol, horizon::Int)
    horizon_demand = 0
    for edge in get_outedges(SC, node_code)
        # NOTE: Want to avoid using if statements here, so giving back a default named tuple for now
        𝒟 = get(edge.SKU_data, SKU, (D=0, T=1))
        horizon_demand += mean(𝒟.D) * (horizon / 𝒟.T)
    end
    return horizon_demand
end

"""
Compute a node's total expected demand for all SKUs (?)
"""
get_total_demand(sc::MetaGraph, label::Symbol) = foldl(
    (u, v) -> begin
        [get(u, i, 0) + get(v, i, 0) for i in 1:max(length(u), length(v))]
    end,
    (@. (eoq.horizon / edge.interval) * mean.(edge.demand_dist) for edge in get_outedges(sc, node_label))
)


