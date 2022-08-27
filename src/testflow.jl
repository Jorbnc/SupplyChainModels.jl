data = DataFrame(
    :Arrival_DT => [
        DateTime(2022, 08, 21, 7, 35, 0), DateTime(2022, 08, 21, 7, 45, 0),
        DateTime(2022, 08, 21, 8, 10, 0), DateTime(2022, 08, 21, 9, 30, 0),
        DateTime(2022, 08, 21, 10, 15, 0), DateTime(2022, 08, 21, 10, 30, 0),
        DateTime(2022, 08, 21, 11, 05, 0), DateTime(2022, 08, 21, 12, 35, 0),
        DateTime(2022, 08, 21, 14, 30, 0), DateTime(2022, 08, 21, 14, 35, 0),
        DateTime(2022, 08, 21, 14, 40, 0)
    ],
    :Departure_DT => [
        DateTime(2022, 08, 21, 8, 50, 0), DateTime(2022, 08, 21, 10, 05, 0),
        DateTime(2022, 08, 21, 10, 10, 0), DateTime(2022, 08, 21, 10, 30, 0),
        DateTime(2022, 08, 21, 11, 15, 0), DateTime(2022, 08, 21, 13, 15, 0),
        DateTime(2022, 08, 21, 13, 35, 0), DateTime(2022, 08, 21, 15, 05, 0),
        DateTime(2022, 08, 21, 15, 45, 0), DateTime(2022, 08, 21, 17, 20, 0),
        DateTime(2022, 08, 21, 18, 10, 0)
    ]
)

df_config(data)
flow_plot(data.Arrival_Floor_Int, data.Departure_Floor_Int)

# TEST
# TO DO: Understand (dig into Makie source code) what the function defined below does
# TO DO: https://makie.juliaplots.org/stable/documentation/recipes/ ---> CREATE A RECIPE FOR THIS
function stairpts(s)
    pts = s.plots[1].converted[1][]
    [p[1] for p in pts], [p[2] for p in pts]
end

fig = Figure()
ax = Axis(fig[1,1])
xs = [1,2,5,8,10,12,13,20]; ys = [1,2,3,4,3,4,2,2]

s = stairs!(xs, ys, step=:post, color=:black)
s.plots[1].converted[1]


xs_, ys_ = stairpts(s)
band!(xs_, 0*ys_, ys_, color=(s.color, 0.25))
#ax.xticks=xs
DataInspector(fig)
display(fig)