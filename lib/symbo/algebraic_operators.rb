# frozen_string_literal: true

module Symbo
  module AlgebraicOperators
    using Symbo

    def +(other)
      Sum[self, other]
    end

    def -@
      Product[-1, self]
    end

    def *(other)
      if other.respond_to?(:to_a)
        other.class[*other.to_a.map { |each| Product[self, each].simplify }]
      else
        Product[self, other]
      end
    end

    def /(other)
      if (is_a?(Integer) || is_a?(Complex)) && other.is_a?(Integer)
        Fraction[self, other]
      else
        Quot[self, other]
      end
    end

    def **(other)
      Power[self, other]
    end
  end
end
