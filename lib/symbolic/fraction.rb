# frozen_string_literal: true

module Symbolic
  # Symbolic fraction computation
  class Fraction
    attr_reader :operands

    def initialize(*operands)
      @operands = operands
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

    def ==(other)
      @operands == other.operands
    end
  end
end

def Fraction(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Fraction.new(*operands)
end
