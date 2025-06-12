abstract type AbstractDemand end
const UnivariateDemand = Union{Distribution{Univariate,Continuous},Distribution{Univariate,Discrete}}

abstract type AbstractAgent end
abstract type AbstractLink end

abstract type InventoryPolicy end
abstract type ManufacturingPolicy end

abstract type AbstractSimulator end
