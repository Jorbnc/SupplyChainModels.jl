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
    Q⭐ = sqrt(2*ct*demand/ce)
    T_raw = Q⭐/demand
    T = Dec64(T_raw*time_units[2])
    N = 1/T_raw
    
    # Inventory Position
    # ROP_IP = demand*lead_time/time_units[2]

    # Costs (not accounting for pipeline inventory cost, i.e. for lead_time > 0)
    OrderingCost = ct*N
    HoldingCost = ce*(Q⭐/2)
    TRC() = OrderingCost + HoldingCost
    TC(c::Union{Signed,AbstractFloat}) = TRC() + c*demand

    # Inventory Policy
    policy(c::Union{Signed,AbstractFloat}) = Dict(
        "Q⭐"=>Q⭐, "T_raw"=>T_raw, "T"=>T, "N"=>N, "TRC"=>TRC(), "TC" => TC(c))

    function policy_for(s::String, value::Union{Signed, AbstractFloat})
        if s == "Q"
            Q_for = value
            T_raw_for = value/demand
            T_for = T_raw_for*time_units[2]
            N_for = 1/T_raw_for
        elseif s == "T"
            T_for = value
            N_for = time_units[2]/value
            Q_for = demand/N_for
        else
            return "Invalid input"
        end
        OrderingCost_for = ct*N_for
        HoldingCost_for = ce*(Q_for/2)
        TRC_for() = OrderingCost_for + HoldingCost_for
        TC_for(c::Union{Signed,AbstractFloat}) = TRC_for() + c*demand
        return Dict("Q"=>Q_for, "T"=>T_for, "N"=>N_for, "TRC"=>TRC_for(), "TC" => TC(c))
    end

    # [Required] Returning a function with "public" elements inside
    ()->(Q⭐, T_raw, T, N,
    OrderingCost, HoldingCost, TRC, TC,
    policy, policy_for)
end

"""
Intermediary function to simplify input for eoq_execute()
"""
function eoq(;demand, ct, ce, time_units=("m",12), lead_time=0)
    d = Dict(:demand=>demand, :ct=>ct, :ce=>ce, :time_units=>time_units, :lead_time=>lead_time)
    return eoq_execute(;d...)
end

end # Module EOQ

# Basic output
a = EOQ.eoq(ct=500, demand=2000, ce=50*0.25)
a.Q⭐
a.T_raw
a.T
a.N

# Costs
a.HoldingCost
a.OrderingCost
a.TRC()
a.TC(50)

# Policy
a.policy(50)
a.policy_for("Q", 500)
a.policy_for("T", 3.0)

# Falta fixear el tema del input c ---> Quizá deba incluirlo desde el primer input (eoq())