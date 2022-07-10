net = MetaDiGraph(SimpleDiGraph(Edge.([
    1 => 2;
    2 .=> [4, 7];
    3 => 4;
    4 .=> [5, 6, 7];
    6 .=> [8, 9]
    ])))
plot_network(net; 
    nlabels=[
        "Supplier1", 
        "MWH1", "MWH2",
        "P",
        "DC1", "DC2",
        "Retailer1", "Retailer2", "Retailer3"
        ],
    force_pos=[3=>2, 7=>5])


chain = [
    :Sup1 => :MWH1;
    :MWH1 .=> [:P, :Ret1];
    :MWH2 => :P;
    :P .=> [:DC1, :DC2, :Ret1];
    :DC2 .=> [:Ret2, :Ret3]
    ]

net2 = schain(chain)
plot_network(net2)