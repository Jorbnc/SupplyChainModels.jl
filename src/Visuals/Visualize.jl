"""Plot network as a graph."""
function plot_network(
		network::AbstractMetaGraph;
		nlabels::Union{Array{String, 1}, Nothing}=nothing,
		elabels::Union{Array{String, 1}, Nothing}=nothing,
		fixedpos::Union{Dict{Int, Int}, Nothing}=nothing)
	fig = Figure()
	ax = Axis(fig[1,1], yautolimitmargin=(0.05,0.1), xautolimitmargin=(0.1, 0.1)) # To avoid text clipping
	nlabels = nlabels !== nothing ? nlabels : string.(collect(vertices(network)))
	xs, ys, paths = solve_positions(Zarate(), network)

	# Look for an inline version of the following conditional + loop
	if fixedpos !== nothing
		for node in keys(fixedpos)
			xs[node] = fixedpos[node]
		end
	end
	
	# ys .= 1 .* ys
	foreach(v -> v[2] .= 1 .* v[2], values(paths))
	lay = _ -> Point.(zip(xs,ys))
	graphplot!(network,
		nlabels=nlabels, nlabels_color=:red, nlabels_align=(:center, :bottom), nlabels_distance=5,
		elabels=elabels, elabels_rotation=[0,], elabels_textsize=15,
		layout=lay)
	hidedecorations!(ax); hidespines!(ax); ax.aspect = DataAspect()
	display(fig)
end

export plot_network