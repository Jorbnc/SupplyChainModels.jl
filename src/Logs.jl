# A utility function to pretty-print stock levels for debugging or analysis
function print_supply_chain(sc::MetaGraph)
    println("Supply Chain Status:")
    for vertex in values(sc.vertex_labels)
        agent = sc[vertex]
        println("$vertex: $(agent.stock)")
    end
end

export print_supply_chain
