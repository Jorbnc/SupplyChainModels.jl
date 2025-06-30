export Backorder, Backorder_

"""
Default stockout "policy"
"""
struct StockoutError <: AbstractStockoutPolicy
end

function (stockout::StockoutError)(labelA::Symbol, Q::Real, stock::Real)
    throw(ArgumentError("$labelA has insufficient stock. Requested: $Q, Available: $stock"))
end


"""
Backorder
"""
struct Backorder <: AbstractStockoutPolicy
end

struct Backorder_
end

function (b::Backorder_)(INV, idxA, idxB, idxSKU, Q)
    INV[idxSKU, idxB, 3] += Q
end


function generate_policy(
    SC::MetaGraph, codeA::Int, codeB::Int, SKU::Symbol, SO::Backorder, horizon::Int, indices_SKU::Dict{Symbol,Int}
)
    Backorder_()
end
