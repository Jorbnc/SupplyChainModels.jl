# No Labeling + Forcing position
net1 = Nchain([
    1 => 2;
    2 .=> [4, 7];
    3 => 4;
    4 .=> [5, 6, 7];
    6 .=> [8, 9]
    ]; nlabels=[4=>:Plant],
    force_pos=[3=>2, 7=>5]
    )
plot_network(net1)

# Labeling from the construction itself
chain1 = Schain([
        :Sup1 => :MWH1;
        :MWH1 .=> [:P, :Ret1];
        :MWH2 => :P;
        :P .=> [:DC1, :DC2, :Ret1];
        :DC2 .=> [:Ret2, :Ret3]
    ], 
    force_pos=[:MWH2 => 2,:Ret1 => 5
    ])
plot_network(chain1)

# Transshipment/Transportation problem
arr = Vector{Pair{Symbol, Symbol}}()
for P in [:P1, :P2, :P3, :P4, :P5, :P6]
    append!(arr, P .=> [:DC1, :DC2])
end
for R in [:R1, :R2, :R3, :R4, :R5]
    append!(arr, [:DC1 => R], [:DC2 => R])
end
chain = Schain(arr)
plot_network(chain) # TO DO: Construct/Use an existing layout for this (it's too narrow)

# The following has to be plottd like in Visuals/transshipment_layout.png
chain2 = Schain([
    :Memphis .=> [:NY, :LA, :Chicago, :Boston];
    :Denver .=> [:LA, :NY, :Chicago, :Boston];
    :NY .=> [:Chicago, :LA, :Boston];
    :Chicago .=> [:NY, :LA, :Boston]
    ])
plot_network(chain2)

# This feature could be useful later
# http://juliaplots.org/GraphMakie.jl/stable/generated/interactions/