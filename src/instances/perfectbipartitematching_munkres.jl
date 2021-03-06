mutable struct PerfectBipartiteMatchingMunkresSolver <: PerfectBipartiteMatchingSolver
  weights_matrix::Matrix{Float64}

  function PerfectBipartiteMatchingMunkresSolver()
    return new(zeros(0, 0))
  end
end

function build!(solver::PerfectBipartiteMatchingMunkresSolver, n_arms::Int)
  solver.weights_matrix = zeros(n_arms, n_arms)
  nothing
end

function solve_linear(solver::PerfectBipartiteMatchingMunkresSolver, rewards::Dict{Tuple{Int, Int}, Float64})
  fill!(solver.weights_matrix, 0.0)
  for (k, v) in rewards
    solver.weights_matrix[k[1], k[2]] = v
  end
  solver.weights_matrix = maximum(solver.weights_matrix) .- solver.weights_matrix

  assignment = Munkres.munkres(solver.weights_matrix)
  return collect(enumerate(assignment))
end

has_lp_formulation(::PerfectBipartiteMatchingMunkresSolver) = false
