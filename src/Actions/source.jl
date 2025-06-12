function generate_purchase()
    return
end


"""
    purchase!(supplychain::MetaGraph, buyer::Symbol, item::Int, quantity::Int)

`buyer` purchases `quantity` units of `item` from `supplier`.
"""
function purchase!(
    supplychain::MetaGraph,
    buyer::Symbol,
    supplier::Symbol,
    item_idx::Int,
    quantity::Int
)
    # Assumes single supplier
    buyer_vertex = supplychain[buyer]
    supplier_vertex = supplychain[supplier]

    buyer_capacity = buyer_vertex.capacity[item_idx]
    buyer_stock = buyer_vertex.stock[item_idx]
    supplier_stock = supplier_vertex.stock[item_idx]

    # Checks
    if supplier_stock < quantity
        throw(ArgumentError("$supplier has insufficient stock. Requested: $quantity, Available: $supplier_stock"))
    end

    if buyer_stock + quantity > buyer_capacity
        throw(ArgumentError("$buyer has insufficient capacity. Requested: $quantity, Can only buy: $(buyer_capacity - buyer_stock + quantity)"))
    end

    # In-place stock modification
    supplier_vertex.stock[item_idx] -= quantity
    buyer_vertex.stock[item_idx] += quantity
end
