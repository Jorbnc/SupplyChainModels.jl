module EOQ

using Revise

"""
Simple EOQ model with arguments:
    - demand (constant per unit time)
    - order (set up) cost
    - holding (carrying) cost
Optional arguments:
    - time units ---> Tuple ---> default is ('m' for months, 12) => 1 year
    - lead time (default is 0)
"""
function eoq(demand::Signed, ct::Union{Signed,AbstractFloat}, ce::Union{Signed,AbstractFloat},
    time_units::Tuple{String,Signed}=("m",12), lead_time::Signed=0)
    return sqrt(2*ct*demand/ce)
end

"""
Lead time and not time units
"""
function eoq(demand::Signed, ct::Union{Signed,AbstractFloat}, ce::Union{Signed,AbstractFloat}, lead_time::Signed)
    return sqrt(2*ct*demand/ce)
end

"""
Simple EOQ:
    - Inputs are unit cost (c) + holding/carrying rate (h) instead of ce
    - ce = c*h
"""
function eoq(demand::Signed, ct::Union{Signed, AbstractFloat}, c::Union{Signed, AbstractFloat}, h::AbstractFloat,
    time_units::Tuple{String,Signed}=("m",12), lead_time::Signed=0)
    return sqrt(2*ct*demand/(c*h))
end

function eoq(demand::Signed, ct::Union{Signed, AbstractFloat}, c::Union{Signed, AbstractFloat}, h::AbstractFloat, lead_time::Signed)
    return sqrt(2*ct*demand/(c*h))
end

end

EOQ.eoq(2000, 500, 12.5)
EOQ.eoq(2000, 500, 12.5, ("m", 12))
EOQ.eoq(2000, 500, 12.5, ("m", 12), 0)
EOQ.eoq(2000, 500, 12.5, 0)

EOQ.eoq(2000, 500, 50, 0.25)
EOQ.eoq(2000, 500, 50, 0.25, ("m", 12))
EOQ.eoq(2000, 500, 50, 0.25, ("m", 12), 0)
EOQ.eoq(2000, 500, 50, 0.25, 0)