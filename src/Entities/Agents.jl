module Agents

# --------------------------------------------------------------------------------

# maybe I should import an existing package for this...
abstract type Node end

# --------------------------------------------------------------------------------

# gotta import Functions/Actions.jl
# (make a quick diagram for import/using logic and add it to the Julia cheatsheet)

# ...anyway, follow this
struct Current_node <: Node
    name::String # (must be optional)
    # See <.../Functions>
    actions::Array{Union{Missing, Actions}}
    # (or should I simply use 
    #   > actions::Array{Union{Missing, Functions}}
    # for this ?)
end

struct prev_node <: Node # an also create an next_node (ofc)
    name::String # (must be optional)
    parent::Current_node
    actions::Array{Union{Missing, Function}}
end

# --------------------------------------------------------------------------------

end # Module Entities

