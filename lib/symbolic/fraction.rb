# frozen_string_literal: true

require 'symbolic/expression'

module Symbolic
  # Symbolic fraction computation
  class Fraction < Expression
    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    def *(other)
      Product self, other
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
        Rational(@operands[0], @operands[1]) < v
      when Fraction
        Rational(@operands[0], @operands[1]) < Rational(v.operands[0], v.operands[1])
      else
        true
      end
    end

    def positive?
      Rational(@operands[0], @operands[1]).positive?
    end

    def rational
      Rational @operands[0], @operands[1]
    end

    def numerator
      @operands[0]
    end

    def denominator
      @operands[1]
    end

    def ==(other)
      return false unless other.is_a?(Fraction)

      @operands == other.operands
    end

    def constant?
      true
    end

    def product?
      false
    end

    def integer?
      false
    end

    def fraction?
      true
    end

    def zero?
      @operands[0].zero?
    end

    protected

    def _simplify
      return UNDEFINED if @operands[1].zero?

      self
    end
  end
end

def Fraction(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Fraction.new(*operands)
end
