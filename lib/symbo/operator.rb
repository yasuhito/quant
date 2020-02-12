# frozen_string_literal: true

require 'symbo/fraction'
require 'symbo/integer'
require 'symbo/symbol'

# Symbo Algebra
module Symbo
  using Symbo

  UNDEFINED = :Undefined

  # Symbo computation operators
  module Operator
    def operand(u, i)
      u[i - 1]
    end
  end
end
