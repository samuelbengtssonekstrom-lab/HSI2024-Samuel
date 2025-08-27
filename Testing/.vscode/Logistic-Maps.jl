function orbit(x_0, T, n)
    x = x_0
    orbit_points = zeros(typeof(x),n)
    orbit_points[1] = x_0
    eps = 1e-2
    for i in 1:n-1
        noise = eps * sin(2π * rand())
        x = T(x) 
        x = test(x, noise)
        orbit_points[i+1] = x
    end
    return orbit_points
end

function main()
    eps = 1e-2
    T(x) = 4*x*(1 - x)
    x_0 = rand()
    n = 1_000_000
    orbit_points = orbit(x_0, T, n)
    histogram!(orbit_points, bins= n÷10000, title="Histogram of Orbit Points", xlabel="x", ylabel="Frequency")
end

function test(x, noise)
    (x + noise > 1) ? (x -= noise) : ((x + noise < 0) ? (x -= noise) : (x += noise))
    return x
end