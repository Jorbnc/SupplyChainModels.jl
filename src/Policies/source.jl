export EOQ, EOQ_

"""
Simple EOQ
"""
struct EOQ{C1,C2<:Real} <: AbstractReplenishmentPolicy
    c_hold::C1
    c_order::C2
end

struct EOQ_
    idxA::Int
    idxB::Int
    idxSKU::Int
    Q::Int
    T::Int
end

function EOQ_(
    SC::MetaGraph, codeA::Int, codeB::Int, SKU::Symbol, c_hold::Real, c_order::Real, horizon::Int,
    indices_SKU::Dict{Symbol,Int}
)
    I₀ = SC.vertex_properties[label_for(SC, codeB)][2].SKU_data[SKU].stock
    D = total_expected_demand(SC, codeB, SKU, horizon) - I₀
    Q = sqrt(2 * D * c_order / c_hold)
    T = horizon * (Q / D)
    return EOQ_(codeA, codeB, indices_SKU[SKU], ceil(Q), floor(T))
end

function (R::EOQ_)(t, INV, SO, L)
    # Replenishment
    if t % R.T == 0
        order_inventory!(INV, R.idxA, R.idxB, R.idxSKU, R.Q, SO, L)
        L.active = true
    end

    # LeadTime <consumption>
    if L.active && L()
        INV[R.idxSKU, R.idxB, 1] += INV[R.idxSKU, R.idxB, 2]
        INV[R.idxSKU, R.idxB, 2] = 0
        L.active = false
    end
end

function generate_policy(
    SC::MetaGraph, codeA::Int, codeB::Int, SKU::Symbol, R::EOQ, horizon::Int, indices_SKU::Dict{Symbol,Int}
)
    EOQ_(SC, codeA, codeB, SKU, R.c_hold, R.c_order, horizon, indices_SKU)
end
