# MIT License
#
# Copyright © 2022 Alexander L. Hayes
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

module FawcettAUC

function _trapezoid_area(x1, x2, y1, y2)
    return abs(x1 - x2) * (y1 + y2) / 2
end

function auc(y_true::Vector{Int64}, y_pred::Vector{Float64})
    n_pos = sum(y_true .== 1)
    n_neg = length(y_true) - n_pos

    order = sortperm(y_pred, rev=true)
    l_sorted = y_true[order]
    f_sorted = y_pred[order]

    tp = fp = 0
    fp_prev = tp_prev = 0
    A = 0
    f_prev = -Inf

    @inbounds for i in eachindex(l_sorted)
        if f_sorted[i] != f_prev
            A += _trapezoid_area(fp, fp_prev, tp, tp_prev)
            f_prev = f_sorted[i]
            fp_prev = fp
            tp_prev = tp
        end

        if l_sorted[i] == 1
            tp += 1
        else
            fp += 1
        end
    end

    A += _trapezoid_area(n_neg, fp_prev, n_pos, tp_prev)
    A /= (n_pos * n_neg)

end

end # module
