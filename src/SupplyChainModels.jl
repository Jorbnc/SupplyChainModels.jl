module SupplyChainModels

include("EOQ.jl")
include("entities.jl")

a = EOQ.eoq(ct=500, c=50, demand=2000, ce=50*0.25)
a.Q

# Costs
a.HoldingCost
a.OrderingCost
a.TRC()
a.TC()

# Policy
a.policy()
a.policy_for("Q", 500)
a.policy_for("T", 3.0)

for i in (1:10^4)
    c = rand(45:55)
    b = EOQ.eoq(ct=rand(450:550), c=c, demand=rand(1950:2050), ce=c*0.25)
    b.TC()
end

end # Module EOQ

# No puedo correr los códigos acá (fuera del módulo) ---> Investigar y arreglar

