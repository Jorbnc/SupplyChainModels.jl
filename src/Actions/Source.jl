module Source

using ..Agents # Gotta fix this, or maybe consider not using too many modules
using ..FlowUnits

export purchase, donate

function donate(to::Company, item::FlowUnit, qty::Int)
    to.cap[item][1] += qty
end

function purchase(items::Array{FlowUnit})
    return items[1]
end

end # Module Source