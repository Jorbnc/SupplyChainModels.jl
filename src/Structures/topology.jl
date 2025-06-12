"""
Supply Chain Graph Constructor.
"""
function supplychain()
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

