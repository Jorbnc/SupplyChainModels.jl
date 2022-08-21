# Check length
length(df.Arrival_DT) !== length(df.Departure_DT) && throw(error("Arrival and Departure columns don't have the same length."))

# From DF to Vectors
inflow = df.Arrival_Floor_Int
outflow = df.Departure_Floor_Int

# xs
xs = collect(inflow[begin]:inflow[end])
mft = select(df, [:Departure_Floor_Int, :Arrival_Floor_Int] => (-) => :FlowTime_Int).FlowTime_Int |> maximum

# Proper units
xs = append!(xs, [xs[end]+1])
inflow = append!(inflow, outflow[end])