export Schain, Nchain


abstract type AbstractChain end


"""Chain for edges made from numbers"""
struct Nchain <:AbstractChain
    network::MetaDiGraph
    nlabels::Union{Vector{String}, Nothing}
    layout::Function
end


"""Chain for edges made from strings||symbols"""
struct Schain <: AbstractChain
    network::MetaDiGraph
    nlabels::Vector{String}
    layout::Union{Function, Spring{2, Float64}};
end


"""Nchain contructor function"""
function Nchain(
    chain::Vector{Pair{Int, Int}};
    nlabels::Union{ Vector{Pair{Int, Symbol}}, Vector{Pair{Int, String}}, Bool} = true,
    force_pos::Union{Vector{Pair{Int, Int}}, Nothing} = nothing
    )
    
    # Construct the graph
    g = MetaDiGraph(SimpleDiGraph(Edge.(chain)))
    
    # Labels
    labels = string.(collect(vertices(g)))
    if typeof(nlabels) <: AbstractArray
        for (node, label) in nlabels
            labels[node] = string(label)
        end
    elseif nlabels == false
        labels = nothing
    end

    # Layout
	xs, ys, paths = solve_positions(Zarate(), g)
	# Not actually a list comprehension, but an inline version of a for loop
	force_pos !== nothing && [xs[node] = pos for (node, pos) in force_pos]
	layout = _ -> Point.(zip(xs, ys))

    return Nchain(g, labels, layout)
end


"""Schain constructor function"""
function Schain(
    chain::Union{Vector{Pair{Symbol, Symbol}}, Vector{Pair{String, String}}};
    force_pos::Union{Vector{Pair{Symbol, Int}}, Vector{Pair{String, Int}}, Nothing} = nothing
    )
    # Get vector of unique nodes and labels
    nodes = Vector{}()
    for (a, b) in chain
        union!(nodes, [a, b])
    end
    nlabels = string.(nodes)

    # Assign a number to each labeled node
    d = Dict(value => key for (key, value) in Dict(enumerate(nodes)))
    
    # Construct the graph
    g = MetaDiGraph(length(nodes))
    for (from, to) in chain
        add_edge!(g, d[from], d[to])
    end

    # Layout
    if LayeredLayouts.is_dag(g) # check if g is directed and acyclic
        xs, ys, paths = solve_positions(Zarate(), g)
        # Not actually a list comprehension, but an inline version of a for loop
        force_pos !== nothing && [xs[d[node]] = pos for (node, pos) in force_pos]
        ys .= 1 .* ys # Y positioning
        foreach(v -> v[2] .= 1 .* v[2], values(paths)) # Can't remember what is this for
        layout = _ -> Point.(zip(xs, ys))
        return Schain(g, nlabels, layout)
    else
        return Schain(g, nlabels, Spring())
    end
end