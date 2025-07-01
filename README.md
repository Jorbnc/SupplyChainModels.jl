# SupplyChainModels

A package for graph-based supply chain modelling and simulation, with a focus on multi-echelon, multi-product systems.

## Usage

### Defining the supply chain topology

A supply chain is an instance of the `MetaGraph` type from [MetaGraphsNext.jl](https://juliagraphs.org/MetaGraphsNext.jl/stable/api/#MetaGraphsNext.MetaGraph).
```julia
SC = SupplyChain()
SC |> typeof |> fieldnames
# (:graph, :vertex_labels, :vertex_properties, :edge_data, :graph_data, :weight_function, :default_weight)
```

Naturally, the supply chain is empty at initialization:
```julia
SC.graph
#{0, 0} directed simple Int64 graph
SC.vertex_properties
#Dict{Symbol, Tuple{Int64, AbstractAgent}}()
SC.edge_data
#Dict{Tuple{Symbol, Symbol}, AbstractLink}()
```

Nodes (vertices) can be added using either the `@Node` macro for convenience, or using regular constructors:
```julia
SC[:WH1] = @Node Warehouse begin
    :ItemA => (stock=10_000,) # (initial stock for ItemA)
    :ItemB => (stock=10_000,)
end
SC[:WH2] = @Node Warehouse :ItemB => (stock=10_000,)
SC[:Store] = @Node Store begin
    :ItemA => (stock=450,)
    :ItemB => (stock=700,)
end
SC[:Customer1] = DemandNode() # (demand-only nodes)
SC[:Customer2] = DemandNode()
```

Links (edges) between nodes can be added using the `@Link` macro. Let's first add replenishment links between the two warehouses and the store:
```julia
SC[:WH1, :Store] = @Link ReplenishmentLink begin
    :ItemA => (R=EOQ(5.5, 250), SO=Backorder(), L=LeadTime(20))
end
SC[:WH2, :Store] = @Link ReplenishmentLink begin
    :ItemB => (R=EOQ(4.5, 250), SO=Backorder(), L=LeadTime(0))
end
```
where:
- `R=EOQ(5.5, 250)` is an EOQ replenishment policy with holding cost = `5.5` and ordering cost = `250`.
- `SO=Backorder()` is a simple backordering policy for stockouts.
- `L=LeadTime(20)` is a constant (replenishment) lead time of 10 time units and `LeadTime(0)` means immediate replenishment.
  - We can also use univariate distributions from `Distributions.jl`, e.g., `L=LeadTime(Normal(20))`.

Now let's add simple demand-only links to represent typical inventory consumption:
```julia
SC[:Store, :Customer1] = @Link DemandLink begin
    :ItemA => (D=Poisson(20), T=10, SO=Backorder(), L=LeadTime(0))
end
SC[:Store, :Customer2] = @Link DemandLink begin
    :ItemA => (D=Poisson(5), T=2, SO=Backorder(), L=LeadTime(0))
    :ItemB => (D=Poisson(20), T=2, SO=Backorder(), L=LeadTime(0))
end
```
where:
- `D=Poisson(20), T=10` means sampling demand from the `Poisson(20)` distribution every 10 time units (e.g., days).
- `SO=Backorder(), L=LeadTime(0)` work as in the previous block of code.

### Plotting the supply chain

Once defined, we can visualize the supply chain
```julia
using GLMakie, GraphMakie
scplot(SC, node_color=:tomato, layout=GraphMakie.Stress())
```

![SC Plot Example 1](docs/src/assets/sc1.png)

### Defining the simulation parameters and running the model

```julia
using Random
Random.seed!(1)

# Run the model for 365 days
sim = SimpleSimulator(SC, horizon=365)
run!(SC, sim)

# Results:
sim.INV
# 2×5×3 Array{Float64, 3}:
# [:, :, 1] =
#   8680.0     0.0  134.0  737.0   899.0
#  10000.0  6562.0  475.0    0.0  3663.0
# 
# [:, :, 2] =
#  0.0  0.0  0.0  0.0  0.0
#  0.0  0.0  0.0  0.0  0.0
# 
# [:, :, 3] =
#  0.0  0.0  0.0  0.0  0.0
#  0.0  0.0  0.0  0.0  0.0
```
where:
- `sim.INV[:,:,1]`, `sim.INV[:,:,2]` and `sim.INV[:,:,3]` represent the inventory on-hand, pipeline, and backlog respectively.
- Rows represent different items and columns represent different nodes.

## EOQ

<video src='docs/src/assets/eoq.mp4' width=360/> 

## TODOs
- [ ] EOQ variations
- [ ] Classical continuous and periodic review models
- [ ] Interface for user-defined policies and demand patterns
- [ ] Transportation and fleet management module
- [ ] Production/Manufacturing module
- [ ] Integration with JuMP
