module Source

using ..Agents # Gotta fix this, or maybe consider not using too many modules
using ..FlowUnits

export purchase, donate

function donate(to::Company, item::FlowUnit, qty::Int)
    to.capacity[item].on_hand += qty
end

function purchase(items::Array{FlowUnit})
    return items[1]
end

end # Module Source