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
  T(x) = 4*x*(1-x)
  v = orbit(T, 0.1, 10000)
  plt = histogram(v, normalize = :pdf, label = "Empirical", bins = 100)
  plt

  # %%
  g(x) = 1/(pi*(sqrt(x*(1-x))))
  plot!(plt, g, 0, 1, color=:orange, label = "Density")