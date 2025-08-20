# %%
  function orbit(T, x0, N)
     orb = zeros(typeof(x0), N)
     x = x0
     for i in 1:N
        orb[i] = x
        x = T(x)
     end
     return orb
  end

# %%
  using Plots
  T(x) = mod(1/x,1)
  @time v = orbit(T, 1/π, 1000000)
  plt = histogram(v, normalize = :pdf, label = "Empirical", bins = 100)
  plt

# %%
  g(x) = 1/(log(2)*(1+x))
  plot!(plt, g, 0, 1, color=:orange, label = "Density")