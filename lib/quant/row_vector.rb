# frozen_string_literal: true

require 'matrix'
require 'quant/vector'
require 'symbo'

module Quant
  class RowVector < Vector
    using Symbo

    def *(other)
      product = to_matrix * other.to_matrix
      product[0, 0].simplify
    end

    def to_matrix
      Matrix[@elements.map(&:simplify)]
    end
  end
end
