module SupplyChainModels

include("EOQ.jl")
include("entities.jl")

EOQ.eoq(ct=500, demand=2000, ce=50*0.25)
gym = entities.Supplier("GyM")

end # Module EOQ

@time a = EOQ.eoq(ct=500, c=50, demand=2000, ce=50*0.25)
@time a.Q⭐

# Costs
@time a.HoldingCost
a.OrderingCost
@time a.TRC()
@time a.TC()

# Policy
@time a.policy()
@time a.policy_for("Q", 500)
@time a.policy_for("T", 3.0)

@time for i in (1:10^4)
    c = rand(45:55)
    b = EOQ.eoq(ct=rand(450:550), c=c, demand=rand(1950:2050), ce=c*0.25)
    b.TC()
end

rand(500:600)