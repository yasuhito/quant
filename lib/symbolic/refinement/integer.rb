# frozen_string_literal: true

module Symbolic
  # Integer refinements
  module Refinement
    refine Integer do
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

      def <(other)
        case other
        when Integer
          super other
        when Fraction
          super Rational(other.operands[0], other.operands[1])
        else
          raise 'Not implemented yet'
        end
      end
    end
  end
end
