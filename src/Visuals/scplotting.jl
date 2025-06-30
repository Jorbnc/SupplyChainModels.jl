export scplot

function scplot(SC::MetaGraph)
    labels = repr.(SC.vertex_labels |> sort |> values)
    graphplot(SC, nlabels=labels, arrow_size=20, node_size=15, nlabels_fontsize=15)
end
