module SupplyChainModels

include("EOQ.jl")
include("entities.jl")

EOQ.eoq(ct=500, demand=2000, ce=50*0.25)
a = entities.Supplier("GyM")

end