import SupplyChainModels: scplot

function scplot(SC::MetaGraph; kwargs...)
    labels = repr.(SC.vertex_labels |> sort |> values)
    graphplot(
        SC;
        nlabels=labels,
        nlabels_fontsize=18, nlabels_distance=10.5,
        arrow_size=20, node_size=20,
        node_color=:black,
        kwargs...
    )
end
