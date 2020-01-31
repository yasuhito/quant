# frozen_string_literal: true

module Symbolic
  # Integer refinements
  module Refinement
    refine Integer do
      def simplify
        self
      end

      def base
        UNDEFINED
      end

      def exponent
        UNDEFINED
      end

      def term
        UNDEFINED
      end

      def const
        UNDEFINED
      end

      def compare(v)
        case v
        when Integer
          self < v
        when Fraction
          self < Rational(v.operands[0], v.operands[1])
        else
          true
        end
      end

      def constant?
        true
      end

      def product?
        false
      end
    end
  end
end
