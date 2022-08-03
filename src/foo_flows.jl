using Dates
using DataFramesMeta
# using BenchmarkTools
using GLMakie

# Input: DataFrame
# Look for a more efficient, sophisticated version of the following
begin # This has to be a function with args: n, distrib_for_arrival, distrib_for_flowtime
    n = 50
    df = DataFrame()
    df[!, :Arrival_DT] = repeat([DateTime(2022, 7, 26, 0, 0)], n) .+ Minute.(cumsum(rand(1:15, n))) .+ Second.(rand(1:30, n))
    df[!, :FlowTime_DT] = Minute.(rand(1:15, n)) .+ Second.(rand(1:30, n))
    df[!, :Departure_DT] = Vector{DateTime}(undef, n)
    df[1, 3] = df[1,1] + df[1,2]
    for i in 2:n
        df[i, 3] = max(df[i-1, 3], df[i,1]) + df[i,2]
    end
end

# Tested other versions with map() and broadcasting. They perform the same, but this is simpler
transform!(df, :Arrival_DT => ByRow(x->Int(datetime2unix(x))) => :Arrival_Int)
transform!(df, :Arrival_DT => ByRow(x->Dates.format(x, "yyyy-mm-dd HH:MM:SS")) => :Arrival_String) 

# Plot
# https://lazarusa.github.io/BeautifulMakie/ScattersLines/timeSeries/
fig = Figure()
ax = Axis(fig[1, 1])
xs = df.Arrival_Int # Syntax for Vector conversion
ys = rand(n)
stairs(xs, ys)
ax.xticks = (xs, df.Arrival_String)
display(fig)


# 
difference = diff(arrival_time)

# TODO:
# 1. Function to plot a one-shot Cumulative Inflow/Outflow + WIP Plot from arrival_time and flow_time
#   inputs, for both number and date-time data types.
# 2. Animate a process flow / queue (scatter plot as flow units) with arrival and service times
#   based on probability distributions

