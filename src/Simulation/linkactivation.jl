"""
...
"""
function activate_link!(a::Store, b::EndCustomer, link::EndCustomerLink, t::Int)
    for (idx, (𝒟, interval)) in enumerate(zip(link.demand, link.interval))
        if t % interval == 0
            sell!(a, b, idx, rand(𝒟))
        end
    end
end

"""
...
"""
function activate_link!(a::Warehouse, b::Store, link::InnerLink, t::Int)
end
