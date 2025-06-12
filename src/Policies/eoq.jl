"""
Simple EOQ model with required arguments:
    - demand (constant per unit time), order (set up) cost, holding (carrying) cost
    - holding cost can be calculated as (unit cost)*(holding rate)
"""
function _EOQ(D::UnivariateDemand, c_ordering::T1, c_holding::T2) where {T1,T2<:Real}
    Q = sqrt(2 * ct * demand / ce)
    T_raw = Q / demand
    T = Dec64(T_raw * time_units[2])
    N = 1 / T_raw

    () -> (Q, T_raw, T, N)
end

"""
Simple EOQ model
"""
struct EOQ{T1,T2<:Real} <: InventoryPolicy
    c_ordering::Vector{T1}
    c_holding::Vector{T2}
    T::Int
end

# EOQ constructor with c_unit and %
# EOQ constructor with specific c_holding
EOQ(c_ordering::T1, c_holding::T2, T::Int=365) where {T1,T2<:Real} = EOQ([c_ordering], [c_holding], T)

# get_outedges() could be a dictionary search instead => More efficient multiple calls
get_outedges(sc::MetaGraph, node::Symbol) = (getindex(sc, node, j) for j in outneighbor_labels(sc, node))

# FIX: The function is not dispatching on a particular AbstractAgent subtype (it uses the node's label)
function generate_policy(sc::MetaGraph, node_label::Symbol, eoq::EOQ)
    𝒟_T = foldl(
        (u, v) -> begin
            [get(u, i, 0) + get(v, i, 0) for i in 1:max(length(u), length(v))]
        end,
        (@. (eoq.T / edge.interval) * mean.(edge.demand) for edge in get_outedges(sc, node_label))
    )
    Q_raw = @. sqrt(2 * 𝒟_T * eoq.c_ordering / eoq.c_holding)
    T = @. round(eoq.T * (Q_raw / 𝒟_T)) # WARNING: Maybe is safer to use floor() instead -> More frequent replenishments
    Q = @. round(𝒟_T * (T / eoq.T))
    sc[node_label].policy_f = t -> (Q, T)
end
