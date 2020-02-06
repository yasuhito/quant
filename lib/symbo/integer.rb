# frozen_string_literal: true

require 'symbo/binary_operation'

# Symbolic computation
module Symbo
  # Integer refinements
  refine Integer do
    alias_method :mult, :*

    include BinaryOperation

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

    def sum?
      false
    end

    def fraction?
      false
    end

    def numerator
      self
    end

    def denominator
      1
    end

    def evaluate
      self
    end

    def simplify_rational_number
      self
    end
  end
end

# Matrix などの中で使われる Integer#+ などをハイジャック
class Integer
  alias plus +
  alias mult *

  def +(other)
    plus other
  rescue TypeError
    Sum self, other
  end

  def *(other)
    mult other
  rescue TypeError
    Product self, other
  end
end
