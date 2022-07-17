abstract type AbstractSchain end

"""Chain Constructor"""
struct Schain <: AbstractSchain
    network::MetaDiGraph
    labels::Vector{}
end


"""Creates a MetaDiGraph from Pairs of Strings or Symbols"""
function Schain(chain::Union{Vector{Pair{Symbol, Symbol}}, Vector{Pair{String, String}}})

    # Get vector of unique nodes
    nodes = Vector{}()
    for (a, b) in chain
        union!(nodes, [a, b])
    end

    # Assign a number to each labeled node
    d = Dict(value => key for (key, value) in Dict(enumerate(nodes)))
    
    # Construct and return the graph
    g = MetaDiGraph(length(nodes))
    for (from, to) in chain
        add_edge!(g, d[from], d[to])
    end
    foo = Schain(g, nodes)

    return foo

end

export Schain