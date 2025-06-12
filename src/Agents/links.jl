"""
Link between a Supplier and an external Customer
"""
mutable struct EndCustomerLink{D<:UnivariateDemand,T<:Real} <: AbstractLink
    demand::Vector{D}
    interval::Vector{Int}
    weight::T
end

function EndCustomerLink(demand::UnivariateDemand, interval::Int, weight::T) where {T<:Real}
    return EndCustomerLink([demand], [interval], weight)
end

"""
Link between nodes of a single company or patnership
"""
mutable struct InnerLink{T<:Real} <: AbstractLink
    weight::T
end
