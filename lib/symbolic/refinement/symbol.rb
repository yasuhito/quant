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
        if v.is_a?(Symbol)
          self < v
        else
          !v.compare(self)
        end
      end
    end
  end
end
