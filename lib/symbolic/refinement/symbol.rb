# frozen_string_literal: true

module Symbolic
  # Symbol refinements
  module Refinement
    refine Symbol do
      def base
        self
      end

      def exponent
        1
      end

      def term
        Product(self)
      end

      def const
        1
      end

      def compare(v)
        return self < v if v.is_a?(Symbol)
      end
    end
  end
end
