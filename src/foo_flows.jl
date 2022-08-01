using Dates
using DataFramesMeta

# Input: DataFrame
# Look for a more efficient, sophisticated version of the following
begin # This has to be a function with args: n, distrib_for_arrival, distrib_for_flowtime
    n = 100
    df = DataFrame()
    df[!, :Arrival_DT] = repeat([DateTime(2022, 7, 26, 0, 0)], n) .+ Minute.(cumsum(rand(1:15, n))) .+ Second.(rand(1:30, n))
    df[!, :FlowTime_DT] = Minute.(rand(1:15, n)) .+ Second.(rand(1:30, n))
    df[!, :Departure_DT] = Vector{DateTime}(undef, n)
    df[1, 3] = df[1,1] + df[1,2]
    for i in 2:n
        df[i, 3] = max(df[i-1, 3], df[i,1]) + df[i,2]
    end
end

# Converting datetime to integers. Btw, gotta use transform!
transform!(df, :Arrival_DT => (x -> Int.(datetime2unix.(x)))  => :Arrival_Int)
# Use Arrival_int as x_ticks (?) and String.(Arrival_DT) as x_ticks_labels (?)

# 
difference = diff(arrival_time)

# TODO:
# 1. Function to plot a one-shot Cumulative Inflow/Outflow + WIP Plot from arrival_time and flow_time
#   inputs, for both number and date-time data types.
# 2. Animate a process flow / queue (scatter plot as flow units) with arrival and service times
#   based on probability distributions

