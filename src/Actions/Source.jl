module Source

using ..FlowUnits
#using ...Agents # Gotta fix this, or maybe consider not using too many modules

export purchase, procure #, donate

#= function donate(to::Company, item::FlowUnit, qty::Int)
    to[item] += qty
end =#

function purchase(items::Array{FlowUnit})
    return items[1]
end

function procure()
    # https://www.oxfordlearnersdictionaries.com/definition/english/procure
    return nothing
end

function something()
    # find potential items for a requirement
    # use this terminology
    #   > https://en.wikipedia.org/wiki/Request_for_information
    # notice that wikipedia page considers RFI as a "business process"
end

end # Module Source