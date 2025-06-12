"""
This demand object can be shared upstream (or across a particular path in the DiGraph).
It computes the demand for the given node with respect to its:
- Adjacent topology
- Perceived economic parameters
"""
# Note sure if it should be a struct or a closure/functor
struct SimpleUpstreamDemand{T} <: AbstractDemand
end


