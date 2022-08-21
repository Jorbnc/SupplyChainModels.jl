using Dates
using DataFramesMeta
using GLMakie
# using BenchmarkTools
# using Distributions # Gotta use this once I know more about Queueing Theory

# Input: DataFrame
# Look for a more efficient, sophisticated version of the following
function generate_data(n) # This has to be a function with args: n, distrib_for_arrival, distrib_for_flowtime, etc.
    df = DataFrame()
    df[!, :Arrival_DT] = repeat([round(now(), Dates.Second)], n) .+ Minute.(cumsum(rand(1:4, n))) .+ Second.(rand(1:60, n))
    df[!, :FlowTime_DT] = Minute.(rand(1:4, n)) .+ Second.(rand(1:60, n))
    df[!, :Departure_DT] = Vector{DateTime}(undef, n)
    df[1, 3] = df[1,1] + df[1,2]
    for i in 2:n
        df[i, 3] = max(df[i-1, 3], df[i,1]) + df[i,2]
    end
    df
end

# DateTime to Integer
# Tested other versions with map() and broadcasting. They perform the same, but this is simpler
function df_config(df; precision)
    transform!(df, :Arrival_DT => ByRow(x->floor(x, precision)) => :Arrival_Floor)
    transform!(df, :Departure_DT => ByRow(x->floor(x, precision)) => :Departure_Floor)
    #transform!(df, :Arrival_Floor => ByRow(x->Dates.format(x, "yyyy-mm-dd HH:MM:SS")) => :Arrival_Str)
    #transform!(df, :Departure_Floor => ByRow(x->Dates.format(x, "yyyy-mm-dd HH:MM:SS")) => :Departure_Str)
    transform!(df, :Arrival_Floor => ByRow(x->Int(datetime2unix(x))) => :Arrival_Floor_Int)
    transform!(df, :Departure_Floor => ByRow(x->Int(datetime2unix(x))) => :Departure_Floor_Int)
    # Floor (rounding down)
    factor = convert(Second, precision(1)).value # e.g. convert(Second, Hour(1))
    transform!(df, :Arrival_Floor_Int => ByRow(x->div(x, factor)), renamecols=false)
    transform!(df, :Departure_Floor_Int => ByRow(x->div(x, factor)), renamecols=false)
end

# Plot test
# TO DO: CREATE COPIES INSTEAD OF MODIFYING THE INPUTS IN-PLACE
function inout_plot(inflow::Vector{Int}, outflow::Vector{Int})
    inflow = copy(inflow); outflow = copy(outflow)
    append!(inflow, outflow[end]) # Last inflow time must be equal to the last outflow time (all WIP done)
    insert!(outflow, 1, inflow[1]) # At the very beginning, 0 units have exited the queue
    units = collect(0:length(inflow)-1) # If doesn't work later, check line 33 in the original inout.py
    flow_points = sort(unique(vcat(inflow, outflow)))
    
    fig = Figure()
    ax = Axis(fig[1,1])
    stairs!(inflow, units, step=:pre, color=:black)
    stairs!(outflow, units, step=:post, color=:green)
    DataInspector(fig)
    display(fig)
end

# mft = select(df, [:Departure_Floor_Int, :Arrival_Floor_Int] => (-) => :FlowTime_Int).FlowTime_Int |> maximum

# # Large
# # TO DO: generate_data() function doesn't work properly, it creates impossible departure times
# n=10
# df = generate_data(n)
# df_config(df, precision=Dates.Minute) # ATM can't handle precision like Dates.Minute(5)
# length(df.Arrival_DT) !== length(df.Departure_DT) && throw(error("Arrival and Departure columns don't have the same length."))
# inflow = df.Arrival_Floor_Int
# outflow = df.Departure_Floor_Int
# inout_plot(inflow, outflow)

# Small
entrada = [0, 0, 0, 0, 9, 11, 12, 18, 18, 25] .+ 100
salida = [4, 6, 8, 12, 15, 20, 25, 29, 33, 40] .+ 100
inout_plot(entrada, salida)

# difference = diff(arrival_time)

# TODO:
# 2. Animate a process flow / queue (scatter plot as flow units) with arrival and service times
#   based on probability distributions