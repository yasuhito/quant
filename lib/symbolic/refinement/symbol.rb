# frozen_string_literal: true

module Symbolic
  # Symbol refinements
  module Refinement
    refine Symbol do
      def simplify
        self
      end

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
        if v.is_a?(Symbol)
          self < v
        else
          !v.compare(self)
        end
      end

      def zero?
        false
      end
    end
  end
end
