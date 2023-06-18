"""
glm(formula::FormulaTerm, design::ReplicateDesign, args...; kwargs...)

Perform generalized linear modeling (GLM) using the survey design with replicates.

# Arguments
- `formula`: A `FormulaTerm` specifying the model formula.
- `design`: A `ReplicateDesign` object representing the survey design with replicates.
- `args...`: Additional arguments to be passed to the `glm` function.
- `kwargs...`: Additional keyword arguments to be passed to the `glm` function.

# Returns
A `DataFrame` containing the estimates for model coefficients and their standard errors.

# Examples
```jldoctest
julia> using Survey

julia> apisrs = load_data("apisrs")
200×40 DataFrame
 Row │ Column1  cds             stype    name             sname         ⋯
     │ Int64    Int64           String1  String15         String        ⋯
─────┼───────────────────────────────────────────────────────────────────
   1 │    1039  15739081534155  H        McFarland High   McFarland Hig ⋯
   2 │    1124  19642126066716  E        Stowers (Cecil   Stowers (Ceci
   3 │    2868  30664493030640  H        Brea-Olinda Hig  Brea-Olinda H
   4 │    1273  19644516012744  E        Alameda Element  Alameda Eleme
   5 │    4926  40688096043293  E        Sunnyside Eleme  Sunnyside Ele ⋯
   6 │    2463  19734456014278  E        Los Molinos Ele  Los Molinos E
   7 │    2031  19647336058200  M        Northridge Midd  Northridge Mi
   8 │    1736  19647336017271  E        Glassell Park E  Glassell Park
   9 │    2142  19648166020747  E        Maxson Elementa  Maxson Elemen ⋯
  10 │    4754  38684786041669  E        Treasure Island  Treasure Isla
  11 │    1669  19647336016497  E        Cimarron Avenue  Cimarron Aven
  12 │    2721  25735934737250  H        Tulelake High    Tulelake High
  13 │    1027  15638426010268  M        Jefferson (Thom  Jefferson (Th ⋯
  14 │      63   1611766000715  E        Maloney (Tom) E  Maloney (Tom)
  15 │    5574  48705406051072  E        Bransford Eleme  Bransford Ele
  ⋮  │    ⋮           ⋮            ⋮            ⋮                       ⋱
 187 │     101   1611926001069  E        Markham Element  Markham Eleme
 188 │    3145  30666706099816  E        Greenville Fund  Greenville Fu ⋯
 189 │    3603  33752426108047  E        Victoriano Elem  Victoriano El
 190 │    2562  20652436024012  E        La Vina Element  La Vina Eleme
 191 │    4512  37683386039630  E        Fulton Elementa  Fulton Elemen
 192 │     641  10621666006217  E        Ericson Element  Ericson Eleme ⋯
 193 │    1121  19642126061220  M        Haskell (Pliny   Haskell (Plin
 194 │    4880  39686766042782  E        Tyler Skills El  Tyler Skills
 195 │     993  15636851531987  H        Desert Junior/S  Desert Junior
 196 │     969  15635291534775  H        North High       North High    ⋯
 197 │    1752  19647336017446  E        Hammel Street E  Hammel Street
 198 │    4480  37683386039143  E        Audubon Element  Audubon Eleme
 199 │    4062  36678196036222  E        Edison Elementa  Edison Elemen
 200 │    2683  24657716025621  E        Franklin Elemen  Franklin Elem ⋯
                                          36 columns and 171 rows omitted

julia> srs = SurveyDesign(apisrs)
SurveyDesign:
data: 200×46 DataFrame
strata: none
cluster: none
popsize: [200, 200, 200  …  200]
sampsize: [200, 200, 200  …  200]
weights: [1, 1, 1  …  1]
allprobs: [1.0, 1.0, 1.0  …  1.0]

julia> bsrs = bootweights(srs, replicates = 2000)
ReplicateDesign{BootstrapReplicates}:
data: 200×2046 DataFrame
strata: none
cluster: none
popsize: [200, 200, 200  …  200]
sampsize: [200, 200, 200  …  200]
weights: [1, 1, 1  …  1]
allprobs: [1.0, 1.0, 1.0  …  1.0]
type: bootstrap
replicates: 2000

julia> result = glm(@formula(api00 ~ api99), bsrs, Normal())

2×2 DataFrame
 Row │ Coefficients  SE
     │ Float64       Float64
─────┼─────────────────────────
   1 │    63.2831    9.41358
   2 │     0.949762  0.0135503

```

```jldoctest
julia> using Survey


julia> apisrs = load_data("apisrs")
200×40 DataFrame
 Row │ Column1  cds             stype    name             sname         ⋯
     │ Int64    Int64           String1  String15         String        ⋯
─────┼───────────────────────────────────────────────────────────────────
   1 │    1039  15739081534155  H        McFarland High   McFarland Hig ⋯
   2 │    1124  19642126066716  E        Stowers (Cecil   Stowers (Ceci
   3 │    2868  30664493030640  H        Brea-Olinda Hig  Brea-Olinda H
   4 │    1273  19644516012744  E        Alameda Element  Alameda Eleme
   5 │    4926  40688096043293  E        Sunnyside Eleme  Sunnyside Ele ⋯
   6 │    2463  19734456014278  E        Los Molinos Ele  Los Molinos E
   7 │    2031  19647336058200  M        Northridge Midd  Northridge Mi
   8 │    1736  19647336017271  E        Glassell Park E  Glassell Park
   9 │    2142  19648166020747  E        Maxson Elementa  Maxson Elemen ⋯
  10 │    4754  38684786041669  E        Treasure Island  Treasure Isla
  11 │    1669  19647336016497  E        Cimarron Avenue  Cimarron Aven
  12 │    2721  25735934737250  H        Tulelake High    Tulelake High
  13 │    1027  15638426010268  M        Jefferson (Thom  Jefferson (Th ⋯
  14 │      63   1611766000715  E        Maloney (Tom) E  Maloney (Tom)
  15 │    5574  48705406051072  E        Bransford Eleme  Bransford Ele
  ⋮  │    ⋮           ⋮            ⋮            ⋮                       ⋱
 187 │     101   1611926001069  E        Markham Element  Markham Eleme
 188 │    3145  30666706099816  E        Greenville Fund  Greenville Fu ⋯
 189 │    3603  33752426108047  E        Victoriano Elem  Victoriano El
 190 │    2562  20652436024012  E        La Vina Element  La Vina Eleme
 191 │    4512  37683386039630  E        Fulton Elementa  Fulton Elemen
 192 │     641  10621666006217  E        Ericson Element  Ericson Eleme ⋯
 193 │    1121  19642126061220  M        Haskell (Pliny   Haskell (Plin
 194 │    4880  39686766042782  E        Tyler Skills El  Tyler Skills
 195 │     993  15636851531987  H        Desert Junior/S  Desert Junior
 196 │     969  15635291534775  H        North High       North High    ⋯
 197 │    1752  19647336017446  E        Hammel Street E  Hammel Street
 198 │    4480  37683386039143  E        Audubon Element  Audubon Eleme
 199 │    4062  36678196036222  E        Edison Elementa  Edison Elemen
 200 │    2683  24657716025621  E        Franklin Elemen  Franklin Elem ⋯
                                          36 columns and 171 rows omitted

julia> srs = SurveyDesign(apisrs, weights = :pw)
SurveyDesign:
data: 200×45 DataFrame
strata: none
cluster: none
popsize: [6194.0, 6194.0, 6194.0  …  6194.0]
sampsize: [200, 200, 200  …  200]
weights: [30.97, 30.97, 30.97  …  30.97]
allprobs: [0.0323, 0.0323, 0.0323  …  0.0323]

julia> bsrs = bootweights(srs, replicates=500)
ReplicateDesign{BootstrapReplicates}:
data: 200×545 DataFrame
strata: none
cluster: none
popsize: [6194.0, 6194.0, 6194.0  …  6194.0]
sampsize: [200, 200, 200  …  200]
weights: [30.97, 30.97, 30.97  …  30.97]
allprobs: [0.0323, 0.0323, 0.0323  …  0.0323]
type: bootstrap
replicates: 500

julia> rename!(bsrs.data, Symbol("sch.wide") => :sch_wide)
200×545 DataFrame
 Row │ Column1  cds             stype    name             sname         ⋯
     │ Int64    Int64           String1  String15         String        ⋯
─────┼───────────────────────────────────────────────────────────────────
   1 │    1039  15739081534155  H        McFarland High   McFarland Hig ⋯
   2 │    1124  19642126066716  E        Stowers (Cecil   Stowers (Ceci
   3 │    2868  30664493030640  H        Brea-Olinda Hig  Brea-Olinda H
   4 │    1273  19644516012744  E        Alameda Element  Alameda Eleme
   5 │    4926  40688096043293  E        Sunnyside Eleme  Sunnyside Ele ⋯
   6 │    2463  19734456014278  E        Los Molinos Ele  Los Molinos E
   7 │    2031  19647336058200  M        Northridge Midd  Northridge Mi
   8 │    1736  19647336017271  E        Glassell Park E  Glassell Park
   9 │    2142  19648166020747  E        Maxson Elementa  Maxson Elemen ⋯
  10 │    4754  38684786041669  E        Treasure Island  Treasure Isla
  11 │    1669  19647336016497  E        Cimarron Avenue  Cimarron Aven
  12 │    2721  25735934737250  H        Tulelake High    Tulelake High
  13 │    1027  15638426010268  M        Jefferson (Thom  Jefferson (Th ⋯
  14 │      63   1611766000715  E        Maloney (Tom) E  Maloney (Tom)
  15 │    5574  48705406051072  E        Bransford Eleme  Bransford Ele
  ⋮  │    ⋮           ⋮            ⋮            ⋮                       ⋱
 187 │     101   1611926001069  E        Markham Element  Markham Eleme
 188 │    3145  30666706099816  E        Greenville Fund  Greenville Fu ⋯
 189 │    3603  33752426108047  E        Victoriano Elem  Victoriano El
 190 │    2562  20652436024012  E        La Vina Element  La Vina Eleme
 191 │    4512  37683386039630  E        Fulton Elementa  Fulton Elemen
 192 │     641  10621666006217  E        Ericson Element  Ericson Eleme ⋯
 193 │    1121  19642126061220  M        Haskell (Pliny   Haskell (Plin
 194 │    4880  39686766042782  E        Tyler Skills El  Tyler Skills
 195 │     993  15636851531987  H        Desert Junior/S  Desert Junior
 196 │     969  15635291534775  H        North High       North High    ⋯
 197 │    1752  19647336017446  E        Hammel Street E  Hammel Street
 198 │    4480  37683386039143  E        Audubon Element  Audubon Eleme
 199 │    4062  36678196036222  E        Edison Elementa  Edison Elemen
 200 │    2683  24657716025621  E        Franklin Elemen  Franklin Elem ⋯
                                         541 columns and 171 rows omitted

julia> bsrs.data.sch_wide = ifelse.(bsrs.data.sch_wide .== "Yes", 1, 0)
200-element Vector{Int64}:
 0
 1
 0
 1
 1
 1
 0
 1
 1
 1
 0
 1
 0
 1
 1
 1
 1
 ⋮
 1
 1
 0
 1
 1
 1
 1
 1
 1
 1
 1
 1
 1
 1
 1
 1

julia> model = glm(@formula(sch_wide ~ meals + ell), bsrs, Binomial(), LogitLink())
3×2 DataFrame
 Row │ Coefficients  SE
     │ Float64       Float64
─────┼──────────────────────────
   1 │   1.52305     0.367792
   2 │   0.00975426  0.00992136
   3 │  -0.020892    0.0127774

julia> model.Coefficients
3-element Vector{Float64}:
  1.523050589485398
  0.009754257280017166
 -0.020892038753257364

julia> model.SE
3-element Vector{Float64}:
 0.3677917670351391
 0.00992135631146699
 0.01277742307361805
````
"""

function glm(formula::FormulaTerm, design::ReplicateDesign, args...; kwargs...)
    # Compute estimates for model coefficients
    model = glm(formula, design.data, args...; wts = design.data[!, design.weights], kwargs...)
    main_coefs = coef(model)
  
    # Compute replicate models and coefficients
    n_replicates = parse(Int, string(design.replicates))
    rep_models = [glm(formula, design.data, args...; wts = design.data[!, "replicate_"*string(i)]) for i in 1:n_replicates]
    rep_coefs = [coef(model) for model in rep_models] # vector of vectors [n_replicates x [n_coefs]]
    rep_coefs = hcat(rep_coefs...) # matrix of floats [n_coefs x n_replicates]
    n_coefs = size(rep_coefs)[1]
  
    # Compute standard errors of coefficients
    SE = [std(rep_coefs[i,:]) for i in 1:n_coefs]
    DataFrame(Coefficients = main_coefs, SE = SE)
  end