"""
...
"""
function activate_node!(store::Store, t::Int)
    # Replenishment
    quantity, interval = store.policy_f(t) # FIX: Change for get_policy(store)
    for i in 1:length(store.stock)
        if t % interval[i] == 0
            store.stock[i] += quantity[i]
        end
    end
end

"""
...
"""
function activate_node!(a::Warehouse, t::Int)
end

"""
...
"""
function activate_node!(a::EndCustomer, t::Int)
end
