"""Plot network as a graph."""
function plot_network(
		network::AbstractMetaGraph;
		nlabels::Union{Vector{String}, Nothing} = nothing,
		elabels::Union{Vector{String}, Nothing} = nothing,
		force_pos::Union{
			Vector{Pair{Int, Int}},
			Vector{Pair{Int, Tuple{Int, Int}}}, # TO DO: process this case below
			Nothing} = nothing
		)
	fig = Figure()
	ax = Axis(fig[1,1], yautolimitmargin=(0.05,0.1), xautolimitmargin=(0.1, 0.1)) # To avoid text clipping
	hidedecorations!(ax); hidespines!(ax); ax.aspect = DataAspect()
	xs, ys, paths = solve_positions(Zarate(), network)
	# Not actually a list comprehension, but an inline version of for loop:
	force_pos !== nothing && [xs[node] = pos for (node, pos) in force_pos]
	#ys .= 0.9 .* ys
	foreach(v -> v[2] .= 1 .* v[2], values(paths))
	lay = _ -> Point.(zip(xs,ys))

	nlabels = nlabels !== nothing ? nlabels : string.(collect(vertices(network)))
	graphplot!(network,
		nlabels=nlabels, nlabels_color=:red, nlabels_align=(:center, :bottom), nlabels_distance=5,
		elabels=elabels, elabels_rotation=[0,], elabels_textsize=15,
		layout=lay)
	display(fig)
end

export plot_network