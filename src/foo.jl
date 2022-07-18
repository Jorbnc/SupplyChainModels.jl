# No Labeling + Forcing position
net1 = Nchain([
    1 => 2;
    2 .=> [4, 7];
    3 => 4;
    4 .=> [5, 6, 7];
    6 .=> [8, 9]
    ]; nlabels=[4=>:TheShit],
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
