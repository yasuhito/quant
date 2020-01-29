# frozen_string_literal: true

require 'symbolic/fraction'
require 'symbolic/refinement/integer'
require 'symbolic/refinement/symbol'

# Symbolic Algebra
module Symbolic
  using Symbolic::Refinement

  UNDEFINED = :Undefined

  # Symbolic computation operators
  module Operator
    def operand(u, i)
      u[i - 1]
    end
  end
end
