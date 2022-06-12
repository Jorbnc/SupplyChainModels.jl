module Source

using ..Agents # Gotta fix this, or maybe consider not using too many modules
using ..FlowUnits

export purchase, donate, generate_demand

"""
Add units of an item to the company's on-hand inventory.
"""
function donate(company::Company, item::FlowUnit, qty::Int)
    if company.inventory_status[item].on_hand + qty <= company.inventory_status[item].max_cap
        company.inventory_status[item].on_hand += qty
    else
        println("The quantity exceeds the company's maximum capacity")
    end
end

"""
Buy units of an item from a seller, as long as restrictions aren't broken.
"""
function purchase(buyer::Company, seller::Company, item::FlowUnit, qty::Int)
    if qty <= seller.inventory_status[item].on_hand && buyer.inventory_status[item].on_hand + 
        qty <= buyer.inventory_status[item].max_cap
        seller.inventory_status[item].on_hand -= qty
        buyer.inventory_status[item].on_hand += qty
        println("Bought $qty units!")
    else
        println("Seller doesn't have enough items or qty exceeds buyer's maximum capacity.")       
    end
end

"""
Generate demand for a non-supplier company based on a probability distribution.
"""
function generate_demand(company::Company, item::FlowUnit, qty::Int)
    company.inventory_status[item].demand += qty
end

end # Module Source