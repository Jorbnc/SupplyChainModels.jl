module EOQ

using DecFP

"""
Simple EOQ model with required arguments:
    - demand (constant per unit time), order (set up) cost, holding (carrying) cost
    - holding cost can be calculated as (unit cost)*(holding rate)
Optional arguments:
    - time units ---> Tuple ---> default is ('m' for months, 12) => 1 year
    - lead time (default is 0)
"""
function eoq_execute(;demand::Signed, ct::Union{Signed,AbstractFloat}, ce::Union{Signed,AbstractFloat},
    time_units::Tuple{String,Signed}, lead_time::Signed)
    Q_star = sqrt(2*ct*demand/ce)
    T_star = Q_star/demand
    T_star_unit_time = Dec64(T_star*time_units[2])
    return Q_star, T_star, T_star_unit_time
end

"""Simplifying input for eoq_execute() with an intermediary function"""
function eoq(;demand, ct, ce, time_units=("m",12), lead_time=0)
    d = Dict(:demand=>demand, :ct=>ct, :ce=>ce, :time_units=>time_units, :lead_time=>lead_time)
    return eoq_execute(;d...)
end

end # Module EOQ

# Test: Input combinations
EOQ.eoq(ct=500, demand=2000, ce=50*0.25)
EOQ.eoq(demand=2000, ct=500, ce=12.5, lead_time=0)
EOQ.eoq(demand=2000, ct=500, ce=12.5, time_units=("m",12))
EOQ.eoq(demand=2000, ct=500, ce=12.5, lead_time=0, time_units=("m",12))