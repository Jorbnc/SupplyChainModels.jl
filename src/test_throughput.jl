using SupplyChainModels
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
# IMPORTANT: There could be flow units that enter the system after another one and exit the system earlier
# Since we're only plotting inflow and outflow, first we have to sort Arrival_DT and Departure_DT inputs
# (in ascending time)

# Data transformation and pre-processing
# Tested other versions with map() and broadcasting. They perform the same, but this is simpler
function df_config(df; precision=Dates.Minute)
    # Rounding datetime down to the nearest $precision
    transform!(df, :Arrival_DT => ByRow(x->floor(x, precision)) => :Arrival_Floor)
    transform!(df, :Departure_DT => ByRow(x->floor(x, precision)) => :Departure_Floor)

    # TO DO: This is for plotting xticks as datetime strings
    #transform!(df, :Arrival_Floor => ByRow(x->Dates.format(x, "yyyy-mm-dd HH:MM:SS")) => :Arrival_Str)
    #transform!(df, :Departure_Floor => ByRow(x->Dates.format(x, "yyyy-mm-dd HH:MM:SS")) => :Departure_Str)

    # Datetime to Float to Integer ---> Regardless of the $precision, we'll get this number in seconds so...
    transform!(df, :Arrival_Floor => ByRow(x->Int(datetime2unix(x))) => :Arrival_Floor_Int)
    transform!(df, :Departure_Floor => ByRow(x->Int(datetime2unix(x))) => :Departure_Floor_Int)
    
    # ...we to to convert from Seconds to $precision
    factor = convert(Second, precision(1)).value # e.g. convert(Second, Hour(1))
    transform!(df, :Arrival_Floor_Int => ByRow(x->div(x, factor)), renamecols=false)
    transform!(df, :Departure_Floor_Int => ByRow(x->div(x, factor)), renamecols=false)
end

# DATA FROM MATCHING SUPPLY WITH DEMAND ================================================
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
plot_throughput(data.Arrival_Floor_Int, data.Departure_Floor_Int)
# =====================================================================================

# # Large
# # TO DO: generate_data() function doesn't work properly, it creates impossible departure times
# n=10
# df = generate_data(n)
# df_config(df, precision=Dates.Minute) # ATM can't handle precision like Dates.Minute(5)
# length(df.Arrival_DT) !== length(df.Departure_DT) && throw(error("Arrival and Departure columns don't have the same length."))
# inflow = df.Arrival_Floor_Int
# outflow = df.Departure_Floor_Int
# inout_plot(inflow, outflow)

