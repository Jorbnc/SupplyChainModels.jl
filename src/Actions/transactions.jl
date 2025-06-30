"""
...
"""
function order_inventory!(INV, idxA, idxB, idxSKU, Q, SO, L)

    # A's stock
    stockA = INV[idxSKU, idxA, 1]

    # Order quantity (+ current backorder to B)
    if INV[idxSKU, idxB, 3] > 0
        Q⁺ = Q + INV[idxSKU, idxB, 3]
        INV[idxSKU, idxB, 3] = 0
    else
        Q⁺ = Q
    end

    # ...
    if stockA < Q⁺
        SO(INV, idxA, idxB, idxSKU, Q⁺ - stockA)
        # NOTE: Handle partial replenishments
    else
        # A decrease in A's IOH in order to represent on-transit inventory
        INV[idxSKU, idxA, 1] -= Q⁺
        # Register in B's Pipeline Inventory
        INV[idxSKU, idxB, 2] += Q⁺
    end

end
