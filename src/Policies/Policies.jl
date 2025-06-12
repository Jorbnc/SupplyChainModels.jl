struct NoPolicy <: InventoryPolicy end
export NoPolicy

function generate_policy end

function generate_policy(sc::MetaGraph, node_label::Symbol, policy::NoPolicy)
end

function generate_policies!(sc::MetaGraph)
    for label in values(sc.vertex_labels)
        generate_policy(sc, label, sc[label].policy)
    end
end

export generate_policy, generate_policies!

export EOQ
include("eoq.jl")
