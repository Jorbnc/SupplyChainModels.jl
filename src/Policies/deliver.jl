export AutoSell

struct AutoSell{D<:UnivariateDistribution}
    idxA::Int
    idxB::Int
    idxSKU::Int
    𝒟::D
    T::Int
end

function (s::AutoSell)(t, INV, SO, L)
    if t % s.T == 0
        order_inventory!(INV, s.idxA, s.idxB, s.idxSKU, rand(s.𝒟), SO, L)
        L.active = true
    end

    # LeadTime <consumption>
    if L.active && L()
        INV[s.idxSKU, s.idxB, 1] += INV[s.idxSKU, s.idxB, 2]
        INV[s.idxSKU, s.idxB, 2] = 0
        L.active = false
    end
end
