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

module FawcettROC

export roc

function roc(y_true::Vector{Int64}, y_pred::Vector{Float64})
    n_pos = sum(y_true .== 1)
    n_neg = length(y_true) - n_pos

    order = reverse(sortperm(y_pred))
    l_sorted = y_true[order]
    f_sorted = y_pred[order]

    fp = tp = 0

    r_out = []

    f_prev = -Inf

    i = 1

    while i <= length(l_sorted)

        if f_sorted[i] != f_prev
            push!(r_out, (fp/n_neg, tp/n_pos))
            f_prev = f_sorted[i]
        end

        if l_sorted[i] == 1
            tp += 1
        else
            fp += 1
        end

        i += 1
    end

    push!(r_out, (fp/n_neg, tp/n_pos))

    return r_out

end

end # module
