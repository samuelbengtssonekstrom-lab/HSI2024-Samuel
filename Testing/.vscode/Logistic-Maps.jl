using Plots
function orbit(x_0, T, n)
    x = x_0
    orbit_points = zeros(typeof(x),n)
    orbit_points[1] = x_0
    eps = 1e-1
    for i in 1:n-1
        noise = eps * sin(2π * rand())^3
        x = T(x) 
        x = test(x, noise)
        orbit_points[i+1] = x
    end
    return orbit_points
end

function multiOrbit(x_0, T, n)
    dim = length(x_0)
    v = zeros(typeof(x_0[1]), dim, n)
    v[:,1] = x_0
    T_1(x) = mod(2x,1)
    T_2(x) = mod(1-3x^2,1)
    M = [T_1, T_2]
    for j in 2:n
        for i in 1:dim
            v[i, j] += mod(M[i](v[i, j-1]) + mean(v[:,j-1]),1)
        end
    end
    return v
end

function main()
    T(x) = mod(1-2x^2,1)
    n = 1_000
    dim = 2
    x_0 = rand(dim)
    orbit_points = multiOrbit(x_0, T, n)
    histogram(orbit_points', bins= 10, title="Histogram of Orbit Points", xlabel="x", ylabel="Frequency")
end

function test(x, noise)
    (x + noise > 1) ? (x -= noise) : ((x + noise < 0) ? (x -= noise) : (x += noise))
    return x
end