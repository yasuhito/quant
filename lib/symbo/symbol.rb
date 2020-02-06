# frozen_string_literal: true

# Symbolic computation
module Symbo
  # Symbol refinements
  refine Symbol do
    include BinaryOperation

    def -@
      Product(-1, self)
    end

    def simplify
      self
    end

    # :section: Power Transformation Methods

    # See Symbo::Expression#base
    def base
      self
    end

    # See Symbo::Expression#exponent
    def exponent
      1
    end

    # :section: Basic Distributive Transformation Methods

    # See Symbo::Expression#term
    def term
      Product(self)
    end

    # See Symbo::Expression#const
    def const
      1
    end

    # :section:

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

    def simplify_rational_number
      raise unless self == UNDEFINED

      UNDEFINED
    end
  end
end
