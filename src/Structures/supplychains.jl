export SupplyChain, @SC

"""
Directed Graph Supply Chain Model
"""
# Wrapping the constructor inside another function triggers "constant propagation":
# https://juliagraphs.org/MetaGraphsNext.jl/stable/tutorial/4_type_stability/#Constructor-and-access
function SupplyChain()
    # ...
    return MetaGraph(
        DiGraph();
        label_type=Symbol,
        vertex_data_type=AbstractAgent,
        edge_data_type=AbstractLink,
        #graph_data=nothing
        #weight_function=edge_data -> 1.0,
        #default_weight=1.0,
    )
end

#= const SC = Ref{AbstractGraph}() =#
#==#
#= macro SC(expr) =#
#=     quote =#
#=         SupplyChainModels.SC[] = $(esc(expr)) =#
#=         SupplyChainModels.SC[] =#
#=     end =#
#= end =#
#==#
