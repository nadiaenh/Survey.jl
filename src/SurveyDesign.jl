# Helper function for nice printing
function print_short(x::AbstractVector)
    if length(x) < 3
        print(x)
    else
        print( x[1], ", ", x[2], ", ", x[3], " ...", " (length = ", length(x), ")")
    end
end

"""
Supertype for every survey design type: `SimpleRandomSample`, `ClusterSample`
and `StratifiedSample`.
"""
abstract type AbstractSurveyDesign end

"""
A `SimpleRandomSample` object contains survey design information needed to
analyse surveys sampled by simple random sampling.
TODO: documentation about user making a copy
TODO: add fpc
"""
struct SimpleRandomSample <: AbstractSurveyDesign
    data::DataFrame

    function SimpleRandomSample(data::DataFrame; weights = ones(nrow(data)), probs = 1 ./ weights)
        # add frequency weights, probability weights and sample size columns
        data[!, :weights] = weights
        data[!, :probs] = probs
        # TODO: change `sampsize` and `popsize`
        data[!, :popsize] = repeat([nrow(data)], nrow(data))
        data[!, :sampsize] = repeat([nrow(data)], nrow(data))

        new(data)
    end
end

# `show` method for printing information about a `SimpleRandomSample` after construction
function Base.show(io::IO, design::SimpleRandomSample)
    printstyled("Simple Random Sample:\n")
    printstyled("data: "; bold = true)
    print(size(design.data)[1], "x", size(design.data)[2], " DataFrame")
    printstyled("\nprobs: "; bold = true)
    print_short(design.data.probs)
    # TODO: change fpc
    printstyled("\nfpc: "; bold = true)
    print("\n    popsize: ")
    print_short(design.data.popsize)
    print("\n    sampsize: ")
    print_short(design.data.sampsize)
end

"""
A `StratifiedSample` object holds information necessary for surveys sampled by
stratification.
"""
struct StratifiedSample <: AbstractSurveyDesign
    data::DataFrame
    function StratifiedSample(data::DataFrame, strata::AbstractVector; weights = ones(nrow(data)), probs = 1 ./ weights)
        # add frequency weights, probability weights and sample size columns
        data[!, :weights] = weights
        data[!, :probs] = probs
        # TODO: change `sampsize` and `popsize`
        data[!, :popsize] = repeat([nrow(data)], nrow(data))
        data[!, :sampsize] = repeat([nrow(data)], nrow(data))
        data[!, :strata] = strata

        new(data)
    end
end

# `show` method for printing information about a `StratifiedSample` after construction
function Base.show(io::IO, design::StratifiedSample)
    printstyled("Stratified Sample:\n")
    printstyled("data: "; bold = true)
    print(size(design.data)[1], "x", size(design.data)[2], " DataFrame")
    printstyled("\nprobs: "; bold = true)
    print_short(design.data.probs)
    printstyled("\nstrata: "; bold = true)
    print_short(design.data.strata)
    # TODO: change fpc
    printstyled("\nfpc: "; bold = true)
    print("\n    popsize: ")
    print_short(design.data.popsize)
    print("\n    sampsize: ")
    print_short(design.data.sampsize)
end

"""
A `ClusterSample` object holds information necessary for surveys sampled by
clustering.
"""
struct ClusterSample <: AbstractSurveyDesign
    data::DataFrame
end

# `show` method for printing information about a `ClusterSample` after construction
function Base.show(io::IO, design::ClusterSample)
    printstyled("Simple Random Sample:\n")
    printstyled("data: "; bold = true)
    print(size(design.data)[1], "x", size(design.data)[2], " DataFrame")
    printstyled("\nprobs: "; bold = true)
    print_short(design.data.probs)
    # TODO: change fpc
    printstyled("\nfpc: "; bold = true)
    print("\n    popsize: ")
    print_short(design.data.popsize)
    print("\n    sampsize: ")
    print_short(design.data.sampsize)
end
