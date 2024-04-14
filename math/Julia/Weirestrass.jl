using Plots
using Distributions
using SpecialFunctions

function log_binomial(n, k)
    if k < 0 || k > n
        return -Inf
    elseif k == 0 || k == n
        return 0
    else
        return loggamma(n+1) - loggamma(k+1) - loggamma(n-k+1)
    end
end

function f(x)
    y = 5.0
    for i = 0:1000
        y += (1/2)^i * cos(7^i * π * x)
    end
    return y
end

function g(x, n)
    y = 0.0
    for i = 0:n
        y += exp(log_binomial(n, i) + log(f(i/n)) + i*log(x) + (n-i)*log(1-x))
    end
    return y
end

function plot_f_and_g(n_values)
    x_values = 0:0.001:1  # 定义 x 的取值范围
    p = plot(x_values, f.(x_values), xlabel="x", ylabel="f(x)", label="f(x)")
    for n in n_values
        plot!(p, x_values, g.(x_values, n), label="g(x, $n)")
    end
    display(p)
end

plot_f_and_g(0:40:800)

