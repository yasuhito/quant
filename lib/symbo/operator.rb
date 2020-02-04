# frozen_string_literal: true

require 'symbo/fraction'
require 'symbo/refinement/integer'
require 'symbo/refinement/symbol'

# Symbo Algebra
module Symbo
  using Symbo::Refinement

  UNDEFINED = :Undefined

  # Symbo computation operators
  module Operator
    def operand(u, i)
      u[i - 1]
    end
  end
end
