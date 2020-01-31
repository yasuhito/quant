# frozen_string_literal: true

# require 'symbolic/rational'

# シンボリック計算
module Symbolic
  # 平方根のシンボリック計算
  class Sqrt
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def -@
      -1 * self
    end

    def *(other)
      if other.is_a?(Sqrt)
        Sqrt.new @value * other.value
      elsif other.is_a?(Integer)
        Product.new(self, other)
      end
    end

    def /(other)
      Rational.new(self, other)
    end

    def zero?
      @value.zero?
    end

    def ==(other)
      other.is_a?(Sqrt) && @value == other.value
    end

    def simplify
      svalue = @value.simplify

      if svalue.zero?
        0
      elsif svalue.negative? && (Math.sqrt(-svalue) % 1).zero?
        Complex(0, Math.sqrt(-svalue))
      elsif (Math.sqrt(svalue) % 1).zero?
        Math.sqrt(svalue)
      else
        Sqrt.new(svalue)
      end
    end

    def to_s
      if @value.to_s.length == 1
        "√#{@value}"
      else
        "√(#{@value})"
      end
    end
  end
end

def Sqrt(value) # rubocop:disable Naming/MethodName
  Symbolic::Sqrt.new(value)
end
