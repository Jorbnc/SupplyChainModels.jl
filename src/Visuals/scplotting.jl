function scplot(sc::MetaGraph)
    sc_labels = repr.(sc.vertex_labels |> sort |> values)
    graphplot(sc, nlabels=sc_labels, arrow_size=20)
end
