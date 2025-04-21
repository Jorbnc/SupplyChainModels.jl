# Initialize the supply chain graph
function create_supply_chain(sc_description::String = "A Supply Chain")
    return MetaGraph(
        DiGraph();
        label_type=Symbol,
        vertex_data_type=SCAgent,
        edge_data_type=Float64,
        graph_data=sc_description
    )
end

export create_supply_chain
