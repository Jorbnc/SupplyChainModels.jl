export @Link
export DummyLink, DemandLink, ReplenishmentLink


"""
Helps defining link without too much verbosity:

    SC[:WH, :Store] = @Link link_type :sku => args

    SC[:WH, :Store] = @Link link_type
        :sku => args
        :sku => args
    end
"""
macro Link(type, block)

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
Replenishment Links.
"""
struct ReplenishmentLink{R<:AbstractReplenishmentPolicy,SO<:AbstractStockoutPolicy,L<:LeadTime} <: AbstractLink
    SKU_data::Dict{Symbol,NamedTuple{(:R, :SO, :L),Tuple{R,SO,L}}}
end


"""
Link between a supply agent and a demand agent, with an automatic transaction.
"""
struct DemandLink{D<:UnivariateDistribution,SO<:AbstractStockoutPolicy,L<:LeadTime} <: AbstractLink
    SKU_data::Dict{Symbol,NamedTuple{(:D, :T, :SO, :L),Tuple{D,Int,SO,L}}}
end

