# %%
  using Random
  using Plots

function GaussMap(x)
    if x == 0
        return 0
    else
        return mod(1/x, 1)
    end
end

function ContFracCoeff(x,n)
    coeffs = zeros(n)

    # 1/T^{n-1}(x)- T^n(x)
    
    for i in 1:n
      if x == 0
        break
      end
        coeffs[i] = 1/x - GaussMap(x)
        x = GaussMap(x)
    end
    return coeffs
end

function approx_from_frac(coeffs)
    n = length(coeffs)
    temp = 0
    for i in n:-1:1
      if coeffs[i] == 0
      else
        temp = coeffs[i] + 1/temp
      end
    end
    return 1/temp    
end

# %%
    #Random.seed!(1234)
    n = 10
    x = rand()
    println("x equals: ", x)
    coeffs = ContFracCoeff(x, n)

    approx = approx_from_frac(coeffs)
    println("Approximation from continued fraction: ", approx)
