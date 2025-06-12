#export ...
include("demands.jl")

export SCAgent, Warehouse, Store, EndCustomer
include("scagents.jl")

export InnerLink, EndCustomerLink
include("links.jl")
