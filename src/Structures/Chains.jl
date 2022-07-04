"""Creates a MetaDiGraph from Pairs of Strings or Symbols"""
function schain(arcs::Union{Pair{String, String}, Pair{Symbol, Symbol}}...)
    println(arcs)
    println(typeof(arcs))
end

export schain