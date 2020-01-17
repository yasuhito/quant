# frozen_string_literal: true

require 'symbolic/base'

module Symbolic
  # シンボリックなべき乗
  class Pow < Base
    def initialize(base, exponent)
      @base = base
      @exponent = exponent
    end

    def simplify
      base = @base.is_a?(Base) ? @base.simplify : @base
      exponent = @exponent.is_a?(Base) ? @exponent.simplify : @exponent

      if base.is_a?(Symbolic::Napier)
        # オイラーの公式より
        # e^(iθ)＝cosθ+isinθ
        if exponent.numerator.multiplier.imag.to_f / exponent.denominator == 0.25
          Sum.new(Rational.new(1, Sqrt.new(2)), Product.new(1i, Rational.new(1, Sqrt.new(2)))).simplify
        else
          theta = (exponent.numerator.multiplier.imag.to_f / exponent.denominator) * Math::PI
          Sum.new(Math.cos(theta), Product.new(1i, Math.sin(theta))).simplify
        end
      else
        self.class.new(base, exponent)
      end
    end

    def zero?
      false
    end

    def inspect
      "#{@base.inspect}^{#{@exponent.inspect}}"
    end
  end
end
