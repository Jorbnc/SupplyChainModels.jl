export Constant
export AbstractAgent, AbstractLink

# Abstract Types and Methods
import Base.Broadcast: broadcastable

# Agents (Nodes) and Links
abstract type AbstractAgent end
abstract type AbstractLink end

# Policies
abstract type AbstractPolicy end
broadcastable(P::AbstractPolicy) = Ref(P)
abstract type AbstractReplenishmentPolicy <: AbstractPolicy end
abstract type AbstractStockoutPolicy <: AbstractPolicy end
#= abstract type AbstractManufacturingPolicy <: AbstractPolicy end =#

# Simulator
abstract type AbstractSimulator end

# Demand Distributions
abstract type AbstractDemand end

import Distributions: DiscreteUnivariateDistribution
import Base: rand

# Deterministic Distribution
struct Constant{R<:Real} <: DiscreteUnivariateDistribution
    C::R
end

# https://juliastats.org/Distributions.jl/stable/extends/#Univariate-Distribution
rand(::AbstractRNG, d::Constant) = d.C
Distributions.mean(d::Constant) = d.C
