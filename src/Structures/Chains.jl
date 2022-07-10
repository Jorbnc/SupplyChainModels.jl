"""Creates a MetaDiGraph from Pairs of Strings or Symbols"""
function schain(arcs::Union{ Vector{Pair{Symbol, Symbol}},  Vector{Pair{String, String}}})

    # Get vector of unique nodes
    nodes = Vector{}()
    for (a, b) in arcs
        union!(nodes, [a, b])
    end

    # Assign a number to each (labeled) node
    d = Dict(value => key for (key, value) in Dict(enumerate(nodes)))
    
    # Construct and return the graph
    g = MetaDiGraph(length(arcs))
    for (from, to) in arcs
        add_edge!(g, d[from], d[to])
    end
    g
end

export schain