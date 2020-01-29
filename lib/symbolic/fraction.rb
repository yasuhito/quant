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

    def ==(other)
      @operands == other.operands
    end
  end
end

def Fraction(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Fraction.new(*operands)
end
