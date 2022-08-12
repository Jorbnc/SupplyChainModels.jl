using Dates
using DataFramesMeta
# using BenchmarkTools
using GLMakie
# using Distributions # Gotta use this once I know more about Queueing Theory

# Input: DataFrame
# Look for a more efficient, sophisticated version of the following
function generate_data(n) # This has to be a function with args: n, distrib_for_arrival, distrib_for_flowtime, etc.
    df = DataFrame()
    df[!, :Arrival_DT] = repeat([round(now(), Dates.Second)], n) .+ Minute.(cumsum(rand(1:4, n))) .+ Second.(rand(1:60, n))
    df[!, :FlowTime_DT] = Minute.(rand(1:5, n)) .+ Second.(rand(1:60, n))
    df[!, :Departure_DT] = Vector{DateTime}(undef, n)
    df[1, 3] = df[1,1] + df[1,2]
    for i in 2:n
        df[i, 3] = max(df[i-1, 3], df[i,1]) + df[i,2]
    end
    df
end

# DateTime to Integer (Seconds after )
# Tested other versions with map() and broadcasting. They perform the same, but this is simpler
function stair_config(units)
    transform!(df, :Arrival_DT => ByRow(x->floor(x, units)) => :Arrival_Int)
    #transform!(df, :Arrival_DT => ByRow(x->Int(datetime2unix(x))) => :Arrival_Int)
    #transform!(df, :Arrival_DT => ByRow(x->Dates.format(x, "yyyy-mm-dd HH:MM:SS")) => :Arrival_Str)
end

df = generate_data(100)
# stair_config(Dates.Minute(5)) # Could be very useful
stair_config(Dates.Minute)

# Plot
# fig = Figure()
# ax = Axis(fig[1, 1])
# xs = df.Arrival_Int


# Plot test
# fig = Figure()
# ax = Axis(fig[1, 1])
# xs = df.Arrival_Int # Syntax for conversion to Vector
# ys = rand(n)
# stairs!(xs, ys)
# #ax.xticks = (xs, df.Arrival_Str) # There's no sense in using xticks
# inspector = DataInspector(fig) # I'd rather use a mouseover display
# display(fig)



# 
# difference = diff(arrival_time)

# TODO:
# 1. Function to plot a one-shot Cumulative Inflow/Outflow + WIP Plot from arrival_time and flow_time
#   inputs, for both number and date-time data types.
# 2. Animate a process flow / queue (scatter plot as flow units) with arrival and service times
#   based on probability distributions

