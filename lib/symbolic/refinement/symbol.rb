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
          if self == :π
            -1
          else
            self < v
          end
        else
          !v.compare(self)
        end
      end

      def product?
        false
      end

      def sum?
        false
      end

      def constant?
        false
      end

      def zero?
        false
      end
    end
  end
end
