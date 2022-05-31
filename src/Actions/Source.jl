module Source

using ..FlowUnits

export purchase, procure

function purchase(items::Union{Array{Raw}, Array{Component}, Array{Product}})
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
    # should I model fundamental business processes?
end

end # Module Source