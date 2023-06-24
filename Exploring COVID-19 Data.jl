url = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"

typeof(url)

url * url

@which url * url

(1 + 2im) * (5 + 7im)

@which (1 + 2im) * (5 + 7im)

*

url

download(url, "covid_data.csv")

readdir

readdir()

using Pkg
Pkg.add("CSV")

using CSV

using Pkg
Pkg.add("DataFrames")

using DataFrames
CSV.read("covid_data.csv", DataFrame)

data = CSV.read("covid_data.csv", DataFrame); # ; suppresses the display of output

typeof(data)

rename!(data, 1=> "Province", 2=>"Country") # ! is convention: function modifies its argument in place

data #this data is also changed due to !

using Pkg
Pkg.add("Interact")

using Interact

for i in 1:10
    @show i
end

typeof(1:10)

collect(1:10)

using Pkg
Pkg.add("WebIO")
using WebIO

@manipulate for i in 1:10
    HTML(i^2)
end

using Pkg
Pkg.add("IJulia")

countries = collect(data[1:end,2])

unique_countries = unique(countries)

@manipulate for i in 1:length(countries)
    countries[i]
end

countries[end]

@manipulate for i in 1:length(countries)
    data[i,1:15]
end

startswith("United","U")

startswith("David","U")

U_countries = [startswith(country, "U") for country in countries]

data[U_countries, :]

countries == "US"

countries .== "US" # . is broadcasting, applying to each element of a vector

findfirst( countries .== "US")

US_row = findfirst( countries .== "US")

US_data_row = data[US_row, :]

 US_data_row[5:end]

US_data = collect( US_data_row[5:end])

using Pkg
Pkg.add("Plots")

using Plots

plot(US_data)

names(data)

date_strings = String.(names(data))[5:end]; # apply string function to each element

date_strings[1]

using Dates

format = Dates.DateFormat("m/d/Y")

parse(Date, date_strings[1], format) 

parse(Date, date_strings[1], format) + Year(2000)

dates = parse.(Date, date_strings, format) .+ Year(2000)

plot(dates, US_data, xticks = dates[1:4:end], xrotation=45, leg=:topleft, label="US data", m=:o,
yscale=:log10)

xlabel!("date")
ylabel!("confirmed cases in US")
title!("US Confirmed Covid-19 Cases")

function f(country)
    return country
end

f("US")

I_0 = 1 # if this looks ugly simply do this I\_0 and then press tab-key

I₀ = 1

c = 0.01 # average no of people each individual infects on each day

λ = 1 + c #\lambda <TAB>

I_1 = λ * I_0

I_2 = λ * I_1

I_3 = λ * I_2

T = 10       # final time
I = zeros(T)

I

I[1:2]

I = zeros(Int64, T)

I = zeros(T)

I[1] = I_0 # Could use OffsetArrays.jl -- enables arbitrary indexing

for n in 1:T-1
    I[n+1] = λ * I[n]
    @show n, I[n]
end

# for loops do not return anything so running a for loop doesn't output

I[T]

using Plots

plot(I, m=:o, label="I[n]", legend=:topleft)

T=20
I=zeros(T)
I[1]=I_0
for n in 1:T-1
    I[n+1] = λ * I[n]
    @show n, I[n]
end

plot(I)

function run_infection(T=20) #default value
    I=zeros(T)
    I[1]=I_0
    
    for n in 1:T-1
        I[n+1] = λ * I[n]
    end

    return I
end

methods(run_infection)

run_infection(10)

I_result = run_infection(10)

I_result

plot(run_infection(20),m=:0)

end_T = 1000
@manipulate for T in slider(1:end_T, value = 1)
    I_result = run_infection(T)
    
    plot(I_result, m=:o)
    xlims!(0, end_T)
    ylims!(0,10)
end

plot(run_infection(1000))

plot(run_infection(1000), yscale=:log10)

I_result = run_infection(1000)

plot(log10.(I_result)) # log of each element in I_result
ylabel!("log(I_n)")

p = 0.02
α = 0.01
N = 1000

β(I, S) = p * α * (N-I)

function run_infection(T=20) #default value
    I=zeros(T)
    I[1]=I_0
    
    for n in 1:T-1
        I[n+1] = I[n] + β(I[n], N-I[n]) * I[n]
    end

    return I
end

I = run_infection(20)

plot(I, m=:o)

plot(I, m=:o, yscale=:log10)

I = run_infection(100)

p = 0.01
α = 0.1
N = 100
I = run_infection(100)
plot(I, m=:o)

I = run_infection(100)
plot(I, m=:o, yscale=:log10)

rand()

rand()

randn() # using Gaussian distributions

p = 0.02
α = 0.01
N = 1000



function run_infection(c_average=1.1 , T=20) #default value
    I=zeros(T)
    I[1]=I_0
    
    for n in 1:T-1
        c = c_average + 0.1*randn()
        I[n+1] = I[n] + c * I[n]
    end

    return I
end

c_average = 1.1
cs = [c_average + 0.1*randn() for _ in 1:100] # i isn't being used in the value, so replaced it with _

scatter(cs)

const a = UInt(6364136223846793005) # unsigned integer
const b = UInt(1442695040888963407)

my_rand_int(x) = a*x + b

x = UInt(3)
for i in 1:10
    global x = my_rand_int(x)
    y = x / typemax(UInt) # convert to interval [0, 1)
    @show y
end

jump() = rand((-1,1))

bernoulli(p) = rand() < p

bernoulli(0.25)

jump()

[jump() for i in 1:10]

function walk(n)
    x = 0
   for i in 1:n
        x = x + jump()
    end
    return x
end

walk(10)

function trajectory(n)
    x = 0
    xs = [x]
   for i in 1:n
        x = x + jump()
        push!(xs, x)
    end
    return xs
end

trajectory(10)

using Plots

traj = trajectory(100)

plot(traj, m=:o)
hline!([0], ls=:dash)

num_walkers = 1000
num_steps = 100

p = plot(size(500, 400), leg = false)
for i in 1:num_walkers
    traj = trajectory(num_steps)
    plot!(traj)
end
p

using Interact

@manipulate for n in 1:25
    traj = trajectory(n)
    plot(traj)
end

n = 20
traj = trajectory(n)

@manipulate for i in slider(1:n, value = 1)
    plot(traj[1:i])
    xlims!(0,n)
    ylims!(-3,3)
end

n = 20
walkers = [trajectory(n) for i in 1:1000]
final_positions = [traj[end] for traj in walkers];

scatter(final_positions)

using Pkg
Pkg.add("StatsBase")

using StatsBase

cnt = countmap(final_positions)

scatter(cnt)

n = 100 # Gaussian Distribution
num_walkers = 10_000
walkers = [trajectory(n) for i in 1:num_walkers]
final_positions = [traj[end] for traj in walkers]
cnt = countmap(final_positions)
scatter(cnt)

function walk(num_steps)
    x = 0
    for i in 1:num_steps
        x += rand((-1, +1))
    end
    return x
end

walk_steps = 25
walk(num_steps)

experiment(num_steps, num_walks) = [walk(num_steps) for i in 1:num_steps]

data = experiment(20,10000)
data'

using StatsBase

cnt = countmap(data);

using Plots

bar(cnt)

histogram(cnt, bins = 10)
xlabel!("x-positions")

mean(data)

histogram(cnt, normed = true, bins = 10, )

vline!([mean(data)], lv = 3, ls=:dash, leg = false)






