module EOQ

using DecFP
export @d128_str, @d32_str, @d64_str, @d_str, Dec128, Dec32, Dec64, DecFP, exponent10, ldexp10, sigexp
using Plots

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
    # Basic Output
    Q = sqrt(2*ct*demand/ce)
    T = Q/demand
    T_ut = Dec64(T*time_units[2])
    N = 1/T

    # Inventory Position
    #   ROP_IP = demand*lead_time/time_units[2]

    # Costs
    OrderingCost = ct*N
    HoldingCost = ce*(Q/2)
    TRC() = OrderingCost + HoldingCost
    TC(c::Union{Signed,AbstractFloat}) = TRC() + c*demand

    # Returning a function with "public" elements inside
    ()->(Q, T, T_ut, N,
    OrderingCost, HoldingCost, TRC, TC)
end

"""Intermediary function to simplify input for eoq_execute()"""
function eoq(;demand, ct, ce, time_units=("m",12), lead_time=0)
    d = Dict(:demand=>demand, :ct=>ct, :ce=>ce, :time_units=>time_units, :lead_time=>lead_time)
    return eoq_execute(;d...)
end

"""Return N_star"""
function N_star()
    return 1/Base.task_state_runnable
end

"""Plot Costs"""

"""Plot Policy"""

end # Module EOQ

# Basic output
a = EOQ.eoq(ct=500, demand=2000, ce=50*0.25)
a.Q
a.T
a.T_ut
a.N

# Costs
a.HoldingCost
a.OrderingCost
a.TRC()
a.TC(50)