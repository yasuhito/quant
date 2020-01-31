# frozen_string_literal: true

module Symbolic
  # Symbolic fraction computation
  class Fraction
    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    def simplify
      return UNDEFINED if @operands[1].zero?

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

    def *(other)
      case other
      when Integer
        Rational(@operands[0], @operands[1]) * other
      else
        raise 'Not implemented yet'
      end
    end

    def rational
      Rational(@operands[0], @operands[1])
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

    def zero?
      @operands[0].zero?
    end
  end
end

def Fraction(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Fraction.new(*operands)
end
