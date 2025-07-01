export InventoryVisualizer
export scplot

struct InventoryVisualizer{A<:Array{T,3} where {T}} #<: AbstractVisualizer
    obs::A
end

function InventoryVisualizer end

function scplot end
