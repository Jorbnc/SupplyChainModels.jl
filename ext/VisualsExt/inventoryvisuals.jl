import SupplyChainModels: InventoryVisualizer

function InventoryVisualizer(sim::SimpleSimulator, s=(1200, 600))
    # ...
    fig = Figure(size=s)
    axs = Axis[]
    obs = fill(Observable(Point2f[(0, 0)]), size(sim.INV))

    # ...
    for (i, t) in enumerate(("IOH", "Pipeline", "Backorders"))
        push!(axs, Axis(fig[i, 1], title=t))
        limits!(axs[i], -1, sim.horizon, 0, 750) #WARNING: Hardcoded limits

        # Nodes
        for c in 1:size(sim.INV, 2)
            # SKUs
            for r in 1:size(sim.INV, 1)
                obs[r, c, i] = Observable(Point2f[(0, 0)])
                lines!(axs[i], obs[r, c, i], color=:black)
            end
        end
    end
    display(fig)
    return InventoryVisualizer(obs)
end

function (vis::InventoryVisualizer)(t::Int, sim::SimpleSimulator)
    # Type of Invetory
    for i in 1:size(sim.INV, 3)
        # Nodes
        for c in 1:size(sim.INV, 2)
            # SKUs
            for r in 1:size(sim.INV, 1)
                x = Point2f((t, sim.INV[r, c, i]))
                vis.obs[r, c, i][] = push!(vis.obs[r, c, i][], x)
            end
        end
    end
    sleep(1 / sim.horizon)
end
