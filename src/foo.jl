# No Labeling
net1 = MetaDiGraph(SimpleDiGraph(Edge.([
    1 => 2;
    2 .=> [3, 4];
    4 => 5
    ])))
plot_network(net1)

# Manual labeling
chain1 = Schain([
    :Sup1 => :MWH1;
    :MWH1 .=> [:P, :Ret1];
    :MWH2 => :P;
    :P .=> [:DC1, :DC2, :Ret1];
    :DC2 .=> [:Ret2, :Ret3]
    ])
plot_network(chain1)

# Labeling from the construction itself
chain2 = Schain([
    :Chota => :Cajamarca;
    :Cajamarca .=> [:Celendin, :Cajabamba];
    :Cajabamba => :Trujillo ;
    :Trujillo => :Lima
    ])
plot_network(chain2)

# Labeling + Position fixing from construction itself