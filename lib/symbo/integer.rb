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

    # :section: Power Transformation Methods

    # See Symbo::Expression#base
    def base
      UNDEFINED
    end

    # See Symbo::Expression#exponent
    def exponent
      UNDEFINED
    end

    # :section: Basic Distributive Transformation Methods

    # See Symbo::Expression#term
    def term
      UNDEFINED
    end

    # See Symbo::Expression#const
    def const
      UNDEFINED
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手が定数の場合
    # 大小関係で順序を決定
    #
    #   2.compare(4) # => true
    #   2.compare(5/2) # => true
    #
    # - それ以外の場合
    # 常に true
    #
    #   2.compare(:x + :y) # => true
    #   2.compare(:x * :y) # => true
    #   2.compare(2**:x) # => true
    #   2.compare(Factorial(2)) # => true
    #   2.compare(Function(:f, :x)) # => true
    def compare(v)
      case v
      when Integer
        self < v
      when Fraction
        self < v.rational
      else
        true
      end
    end

    # :section: Expression Type Methods

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

    # :section:

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
