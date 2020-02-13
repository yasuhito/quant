# frozen_string_literal: true

module Quant
  class RowVector
    using Symbo

    def self.[](*elements)
      new(*elements)
    end

    def initialize(*elements)
      @elements = elements
    end

    def *(other)
      product = to_matrix * other.to_matrix
      product[0, 0].simplify
    end

    def to_matrix
      Matrix[@elements.map(&:simplify)]
    end

    def to_a
      @elements
    end
  end
end
