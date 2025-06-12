"""
A demand-only agent. Demand distribution is implemented in an `EndCustomerLink`
"""
mutable struct EndCustomer{P<:InventoryPolicy} <: AbstractAgent
    policy::P
end

EndCustomer() = EndCustomer(NoPolicy())

"""
Store or Retailer that has direct contact with an `EndCustomer`
"""
mutable struct Store{P<:InventoryPolicy} <: AbstractAgent
    stock::Vector{Int}
    capacity::Vector{Int}
    policy::P
    policy_f::Function #FIX: This looks OOP

    function Store(stock::Vector{Int}, capacity::Vector{Int}, policy::P) where {P<:InventoryPolicy}
        new{typeof(policy)}(stock, capacity, policy, x -> x)
        # https://discourse.julialang.org/t/how-to-resolve-syntax-too-few-type-parameters-specified-in-new/15766
    end

end

Store(stock::Vector{Int}, policy::P) where {P<:InventoryPolicy} = Store(stock, [typemax(Int) for _ in stock], policy)
Store(stock::Int, policy::P, capacity::Int=typemax(Int)) where {P<:InventoryPolicy} = Store([stock], [capacity], policy)
function Store(;
    stock::Vector{Int},
    policy::P,
    capacity::Vector{Int}=[typemax(Int) for _ in 1:length(stock)],
) where {P<:InventoryPolicy}
    return Store(stock, capacity, policy)
end

"""
Warehouse
"""
mutable struct Warehouse{P<:InventoryPolicy} <: AbstractAgent
    stock::Vector{Int}
    capacity::Vector{Int}
    policy::P
    #upstream_demand::Foo
end

function Warehouse(stock::Vector{Int}, policy::P=NoPolicy()) where {P<:InventoryPolicy}
    Warehouse(stock, [typemax(Int) for _ in stock], policy)
end
Warehouse(stock::Int, capacity::Int=typemax(Int), policy=NoPolicy()) = Warehouse([stock], [capacity], policy)
Warehouse(; stock::Int, capacity::Int=typemax(Int), policy=NoPolicy()) = Warehouse([stock], [capacity], policy)
