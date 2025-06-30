export initialize_link!, initialize_inventory!

function initialize_link! end
#= function update! end =#
#= function on_event! end =#

"""
...
"""
function initialize_inventory!(SC::MetaGraph)

    # Numerical mapping for all the SKUs in the supply chain
    SKU_set = Set(
        SKU for (_, agent) in values(SC.vertex_properties) if hasproperty(agent, :SKU_data)
        for SKU in keys(getfield(agent, :SKU_data))
    )
    N_SKUs = length(SKU_set)
    indices_SKU = Dict(SKU_set .=> 1:N_SKUs)

    # Generate the system inventory 3D-array: IOH, Pipeline, and Backorders
    INV = zeros(Float64, N_SKUs, nv(SC), 3)
    for (code, agent) in values(SC.vertex_properties)
        # Populate the initial IOH
        if hasproperty(agent, :SKU_data)
            for SKU in keys(agent.SKU_data)
                INV[indices_SKU[SKU], code, 1] = agent.SKU_data[SKU].stock
            end
        end
    end

    return INV, indices_SKU
end

"""
Initialize a ReplenishmentLink.
"""
function initialize_link!(
    SC, codeA, codeB, link::ReplenishmentLink, horizon, indices_SKU
)
    foo = []
    for (SKU, (R, SO, L)) in link.SKU_data
        R = generate_policy(SC, codeA, codeB, SKU, R, horizon, indices_SKU)
        SO = generate_policy(SC, codeA, codeB, SKU, SO, horizon, indices_SKU)
        push!(foo, (R, SO, L))
    end
    return foo
end

"""
Initialize an DemandLink.
"""
function initialize_link!(
    SC, codeA, codeB, link::DemandLink, horizon, indices_SKU
)
    foo = []
    for (SKU, (𝒟, T, SO, L)) in link.SKU_data
        s = AutoSell(codeA, codeB, indices_SKU[SKU], 𝒟, T)
        SO = generate_policy(SC, codeA, codeB, SKU, SO, horizon, indices_SKU)
        push!(foo, [s, SO, L])
    end
    return foo
end
