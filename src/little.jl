using SupplyChainModels, Dates, Statistics

data = DataFrame(
    :Arrival_DT => [
        DateTime(2022, 08, 21, 7, 35, 0), DateTime(2022, 08, 21, 7, 45, 0),
        DateTime(2022, 08, 21, 8, 10, 0), DateTime(2022, 08, 21, 9, 30, 0),
        DateTime(2022, 08, 21, 10, 15, 0), DateTime(2022, 08, 21, 10, 30, 0),
        DateTime(2022, 08, 21, 11, 05, 0), DateTime(2022, 08, 21, 12, 35, 0),
        DateTime(2022, 08, 21, 14, 30, 0), DateTime(2022, 08, 21, 14, 35, 0),
        DateTime(2022, 08, 21, 14, 40, 0)
    ],
    :Departure_DT => [
        DateTime(2022, 08, 21, 8, 50, 0), DateTime(2022, 08, 21, 10, 05, 0),
        DateTime(2022, 08, 21, 10, 10, 0), DateTime(2022, 08, 21, 10, 30, 0),
        DateTime(2022, 08, 21, 11, 15, 0), DateTime(2022, 08, 21, 13, 15, 0),
        DateTime(2022, 08, 21, 13, 35, 0), DateTime(2022, 08, 21, 15, 05, 0),
        DateTime(2022, 08, 21, 15, 45, 0), DateTime(2022, 08, 21, 17, 20, 0),
        DateTime(2022, 08, 21, 18, 10, 0)
    ]
)

df_config(data)

function little_brute_force(inflow::Vector{Int}, outflow::Vector{Int})
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
    return flow_points, level_arr
end

points, level = little_brute_force(data.Arrival_Floor_Int, data.Departure_Floor_Int)
all_points = collect(points[begin]:0.0001:points[end])
wip_all = [level[findfirst(x -> point < x, points) - 1] for point in all_points[begin:end-1]]
push!(wip_all, level[end])

# Testing Little's Law
# Process starts at 7:35 and ends at 18:10 => 10 hours and 35 minutes, or 
total_hours = 10 + 35/60
mean_inventory = mean(wip_all)
total_flowtime = (1+2+2+1+0+3+2+2+3+1+2) + (15+20+0+45+15+5+10+30+40+10+40)/60
mean_flowtime = total_flowtime / 11 # There are 11 flow units

flowrate_1 = 11/total_hours # There are 11 flow units
flowrate_2 = mean_inventory/mean_flowtime