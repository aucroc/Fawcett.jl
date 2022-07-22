# Copyright © 2022 Alexander L. Hayes
# MIT License

using Fawcett
using Plots

y_true = [1, 1, 0, 1, 1, 1, 0, 0, 1, 0];
y_pred = [0.9, 0.8, 0.7, 0.6, 0.55, 0.54, 0.53, 0.52, 0.51, 0.505];

out = Fawcett.generate_roc_points(y_true, y_pred)

x = first.(out)
y = last.(out)

fig = plot(x, y, aspect_ratio=:equal, xlims=(-0.05, 1.05), ylims=(-0.05, 1.05), xlabel="1 - Specificity", ylabel="Sensitivity", leg=false)
scatter!(fig, x, y, leg=false)

display(fig)
