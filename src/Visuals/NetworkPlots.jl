function initialize_network_plot()
	fig = Figure()
	ax = Axis(fig[1,1], yautolimitmargin=(0.1,0.1), xautolimitmargin=(0.1, 0.1))
	hidedecorations!(ax); hidespines!(ax); ax.aspect = DataAspect()
	return fig
end


"""Plot the network as a graph."""
function plot_network(
		nchain::Nchain;
		elabels::Union{Vector{String}, Nothing} = nothing
		)
	fig = initialize_network_plot()
	
	graphplot!(
		nchain.network,
		nlabels=nchain.nlabels, nlabels_color=:red, nlabels_align=(:center, :bottom), nlabels_distance=5,
		elabels=elabels, elabels_rotation=[0,], elabels_textsize=15,
		layout=nchain.layout)
	display(fig)
end

function plot_network(
		schain::Schain;
		elabels::Union{Vector{String}, Nothing} = nothing
		)
	fig = initialize_network_plot()
	graphplot!(
		schain.network,
		nlabels=schain.nlabels, nlabels_color=:red, nlabels_align=(:center, :bottom), nlabels_distance=5,
		elabels=elabels, elabels_rotation=[0,], elabels_textsize=15,
		layout=schain.layout)
	display(fig)
end

export plot_network