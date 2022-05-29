# Maybe the following could use other endogenous functions
# Basically I'm using the SCOR model for supply chain actions
# I should checkout papers that evaluate and suggest completeness for the SCOR model
# --------------------------------------------------------------------------------
module Actions

using ..FlowUnits

export purchase

# --------------------------------------------------------------------------------

function procure() # Parameters
    # https://www.oxfordlearnersdictionaries.com/definition/english/procure
end

function source() # Parameters
    # find potential items for a requirement
    # use this terminology
    #   > https://en.wikipedia.org/wiki/Request_for_information
    # notice that wikipedia page considers RFI as a "business process"
    # should I model fundamental business processes?
end

function purchase(items::Array{Union{Raw, Component, Product}}) # Parameters
    println("You've purchased: $items")
end

# --------------------------------------------------------------------------------

function eto() # engineer to order
    #
end

function ato() # assembly to order
    #
end

function mto() # make to order
    #
end

function mts() # make to stock
    #
end

# --------------------------------------------------------------------------------

function deliver()
    #
end

function distribute()
    #
end

function transport()
    #
end

# --------------------------------------------------------------------------------

end # Module Actions