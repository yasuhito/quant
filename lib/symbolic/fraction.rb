# frozen_string_literal: true

module Symbolic
  # Symbolic fraction computation
  class Fraction
    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    def simplify
      return :Undefined if @operands[1].zero?

      self
    end

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

    def ==(other)
      return false unless other.is_a?(Fraction)

      @operands == other.operands
    end
  end
end

def Fraction(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Fraction.new(*operands)
end
