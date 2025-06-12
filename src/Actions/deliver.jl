function deliver()
    return
end

function distribute()
    return
end

function transport()
    return
end

"""
    sell!(buyer::Symbol, item::Int, quantity::Int)

`seller` automatically sells whatever units of item `item_idx` the `buyer` demands.
"""
function sell!(supplier::A, buyer::B, item_idx::Int, quantity::Int) where {A,B<:AbstractAgent}

    buyer_capacity = Inf
    buyer_stock = 0
    supplier_stock = supplier.stock[item_idx]

    # Checks
    if supplier_stock < quantity
        throw(ArgumentError("$supplier has insufficient stock. Requested: $quantity, Available: $supplier_stock"))
    end

    if buyer_stock + quantity > buyer_capacity
        throw(ArgumentError("$buyer has insufficient capacity. Requested: $quantity, Can only buy: $(buyer_capacity - buyer_stock + quantity)"))
    end

    # In-place stock modification
    supplier.stock[item_idx] -= quantity
    #= buyer.stock[item_idx] += quantity =#
end
