# frozen_string_literal: true

module Symbolic
  # Integer refinements
  module Refinement
    refine Integer do
      def simplify
        self
      end

      def base
        :Undefined
      end

      def exponent
        :Undefined
      end

      def term
        :Undefined
      end

      def const
        :Undefined
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
