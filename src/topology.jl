# Initialize the supply chain graph
function create_supply_chain()
    return MetaGraph(
        Graph();
        label_type=Symbol,
        vertex_data_type=SCAgent,
        edge_data_type=Float64,
    )
end

export create_supply_chain
