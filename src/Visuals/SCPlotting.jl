function scplot(sc::AbstractGraph)
    sc_labels = repr.(sc.vertex_labels |> sort |> values)
    @time graphplot(sc, nlabels=sc_labels, arrow_size=20)
end

export scplot
