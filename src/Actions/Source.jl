"""
    purchase(supplychain::MetaGraph, buyer::Symbol, supplier::Symbol, item::Symbol, quantity::Int64)
    
Performs a `purchase` operation between `supplier` and `buyer` for a specific `item`.
Returns a new graph with updated agent stocks, or throws an error if constraints are violated.
"""
function purchase(
    supplychain::MetaGraph,
    buyer::Symbol,
    supplier::Symbol,
    item::Symbol,
    quantity::Int64
)
    # Retrieve supplier and buyer agents
    supplier_agent = supplychain[supplier]
    buyer_agent = supplychain[buyer]

    # Check stock constraints
    supplier_stock = get(supplier_agent.stock, item, 0)
    if quantity > supplier_stock
        throw(ArgumentError("Supplier $supplier has insufficient $item stock. Requested: $quantity, Available: $supplier_stock"))
    end

    # Update stocks (functional style: create new agents)
    updated_supplier = SCAgent(merge(supplier_agent.stock, Dict(item => supplier_stock - quantity)))
    updated_buyer = SCAgent(merge(buyer_agent.stock, Dict(item => get(buyer_agent.stock, item, 0) + quantity)))

    # Update graph (return a new graph with updated vertices)
    updated_sc = deepcopy(supplychain)
    updated_sc[supplier] = updated_supplier
    updated_sc[buyer] = updated_buyer

    return updated_sc
end

export purchase
