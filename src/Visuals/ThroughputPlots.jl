# Helper function to get the "rectangular" points from a stairs plot
# If functions like these become frequent, consider @recipes https://makie.juliaplots.org/stable/documentation/recipes/
function stairs_fill!(s::Makie.Stairs)
    pts = s.plots[1].converted[1][] # [] basically allows to access the value of the Observable --> https://makie.juliaplots.org/stable/documentation/nodes/#triggering_a_change
    xs = [p[1] for p in pts]; ys = [p[2] for p in pts]
    band!(xs, ys, 0*ys, color=(s.color, 0.25)) # band! requires xs and 2 levels at each x
end


"""
Plot that shows the cumulative inflow/outflow and WIP levels through time.
# UPDATE 1: Works for ≥2 flow units entering at the same time.
"""
function plot_throughput(inflow::Vector{Int}, outflow::Vector{Int})
    inflow = copy(inflow); outflow = copy(outflow)
    append!(inflow, outflow[end]) # Last inflow time must be equal to the last outflow time (all WIP done)
    insert!(outflow, 1, inflow[1]) # At the very beginning, 0 units have exited the queue
    units = collect(0:length(inflow)-1)
    flow_points = sort(vcat(inflow, outflow)) # All points of inflow/outflow (even duplicated ones)
    level = 1 # Starts at 1 because the insert! above will cause inflow[1] to be in both vectors, 
            # so the first iteration of the for loop below won't change anything, even though it'd have to add 1
    level_arr = Vector{Int}()
    # TO DO: Look for a more efficient version of the code below (is a for loop necessary?)
    for point in flow_points
        if point in inflow && !(point in outflow)
            level += 1
        elseif point in outflow && !(point in inflow)
            level -= 1            
        end
        append!(level_arr, level)
    end
    
    fig = Figure(resolution=(600,380*0.9))
    ax = Axis(fig[1,1]) # to use something like ax.xticks = x_ticks
    stairs!(inflow, units, step=:pre, color=:black, linewidth=3)
    stairs!(outflow, units, step=:post, color=:grey, linewidth=3)
    stairs_fill!(stairs!(flow_points, level_arr, step=:post, color=:red))
    DataInspector(fig)
    display(fig)
end

export plot_throughput