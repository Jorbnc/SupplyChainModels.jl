module Source

using ..Agents # Gotta fix this, or maybe consider not using too many modules
using ..FlowUnits

export purchase, donate

function donate(to::Company, item::FlowUnit, qty::Int)
    to.capacity[item].on_hand += qty
end

"""
Buy 1 item from a seller, as long as restrictions aren't broken
"""
function purchase(buyer::Company, seller::Company, item::FlowUnit, qty::Int)
    seller_oh = seller.capacity[item].on_hand
    buyer_oh = buyer.capacity[item].on_hand
    buyer_max = buyer.capacity[item].max
    if qty <= seller_oh && buyer_oh + qty <= buyer_max
        seller.capacity[item].on_hand -= qty
        buyer.capacity[item].on_hand += qty
        return "Bought $qty units!"
    else
        return "Seller doesn't have enough items or qty exceeds buyer max capacity"       
    end
end

end # Module Source