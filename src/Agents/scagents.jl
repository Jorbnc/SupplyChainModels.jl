export @Node
export DemandNode, Store, Warehouse


"""
Helps defining nodes without too much verbosity:

    SC[:WH] = @Node Warehouse :B => (stock=10_000,)

    SC[:Store] = @Node Store begin
        :A => (stock=600,)
        :B => (stock=600,)
    end
"""
macro Node(type, block)

    # Initialize pairs :SKU => NamedTuple(...) and last argument
    dict_pairs = Expr[]
    last_arg = nothing

    # Allows to either begin-end blocks or single liners
    statements = block isa Expr && block.head === :block ? block.args : (block,)
    for s in statements
        if s isa Expr
            # If there's an "=>" in the expression, then...
            if s.head === :call && s.args[1] === :(=>)
                push!(dict_pairs, s)
            else # Otherwise, it must be a single argument (e.g., max_capacity)
                last_arg = s
            end
        end
    end

    # Construction
    dict_expr = Expr(:call, :Dict, dict_pairs...)
    if isnothing(last_arg)
        constructor_expr = Expr(:call, esc(type), dict_expr)
    else
        constructor_expr = Expr(:call, esc(type), dict_expr, last_arg)
    end
end


"""
A demand-only agent. Demand distribution is implemented in an `DemandLink`
"""
struct DemandNode <: AbstractAgent
end


"""
Store or Retailer that has direct contact with a `DemandNode`
"""
struct Store{NT<:NamedTuple,C<:Real} <: AbstractAgent
    SKU_data::Dict{Symbol,NT}
    max_capacity::C
end
Store(SKU_data::Dict{Symbol,NT}) where {NT<:NamedTuple} = Store(SKU_data, Inf)


"""
Warehouse
"""
struct Warehouse{NT<:NamedTuple,C<:Real} <: AbstractAgent
    SKU_data::Dict{Symbol,NT}
    max_capacity::C
end
Warehouse(SKU_data::Dict{Symbol,NT}) where {NT<:NamedTuple} = Warehouse(SKU_data, Inf)
