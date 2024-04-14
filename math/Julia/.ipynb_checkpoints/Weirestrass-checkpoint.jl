{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "44d34272-325d-4cc9-84ee-54cebcfd7534",
   "metadata": {},
   "outputs": [],
   "source": [
    "using Plots\n",
    "using Distributions\n",
    "using SpecialFunctions"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "9f3da18c-3b69-49e1-b7f1-c714c44a33be",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "log_binomial (generic function with 1 method)"
      ]
     },
     "execution_count": 18,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function log_binomial(n, k)\n",
    "    if k < 0 || k > n\n",
    "        return -Inf\n",
    "    elseif k == 0 || k == n\n",
    "        return 0\n",
    "    else\n",
    "        return loggamma(n+1) - loggamma(k+1) - loggamma(n-k+1)\n",
    "    end\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "e3a1ff1c-65d5-484d-b1ce-7dad5c2ed361",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "f (generic function with 1 method)"
      ]
     },
     "execution_count": 19,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "\n",
    "function f(x)\n",
    "    y=10\n",
    "    for i = 0:500\n",
    "        y = y + (1/2)^i *cos(7^i*pi*x)\n",
    "    end\n",
    "    return y\n",
    "end\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "52254db6-7ca5-4a8c-b2d4-55540e4301e0",
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "3567048c-f928-4bfd-88c2-43475d328b95",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "g (generic function with 1 method)"
      ]
     },
     "execution_count": 20,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function g(x, n)\n",
    "    log_y = 0.0\n",
    "    for i = 0:n\n",
    "        log_y += log_binomial(n, i) + log(f(i/n)) + i*log(x) + (n-i)*log(1-x)\n",
    "    end\n",
    "    return exp(log_y)\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "cba2c3a6-8109-4279-8882-7cd511c53dd9",
   "metadata": {
    "scrolled": true
   },
   "outputs": [],
   "source": [
    "function plot_f_and_g(n_values)\n",
    "    x_values = 0:0.001:1  # 定义 x 的取值范围\n",
    "    p = plot(x_values, f.(x_values), xlabel=\"x\", ylabel=\"f(x)\", label=\"f(x)\")\n",
    "    for n in n_values\n",
    "        plot!(p, x_values, g.(x_values, n), label=\"g(x, $n)\")\n",
    "    end\n",
    "    display(p)\n",
    "end\n",
    "\n",
    "plot_f_and_g(0:40:400)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "47ab769a-0eb1-4d99-a9ce-feeafb2cb265",
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "80856ae1-d97b-4592-bb59-bb0444b16c8c",
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "40499af6-0db0-419c-b152-420618493c3f",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Julia 1.10.2",
   "language": "julia",
   "name": "julia-1.10"
  },
  "language_info": {
   "file_extension": ".jl",
   "mimetype": "application/julia",
   "name": "julia",
   "version": "1.10.2"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
