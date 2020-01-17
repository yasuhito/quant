# frozen_string_literal: true

require 'symbolic/base'

module Symbolic
  # シンボリックな和
  class Sum < Base
    attr_reader :x
    attr_reader :y
    def initialize(x, y)
      @x = x
      @y = y
    end

    def +(other)
      self.class.new(self, other)
    end

    def zero?
      x = @x.is_a?(Base) ? @x.simplify : @x
      y = @y.is_a?(Base) ? @y.simplify : @y
      x.zero? && y.zero?
    end

    def simplify
      x = @x.is_a?(Base) ? @x.simplify : @x
      y = @y.is_a?(Base) ? @y.simplify : @y

      return 0 if x.zero? && y.zero?

      return x.simplify if y.zero?
      return y.simplify if x.zero?

      # a/b + c/d = (a*d + c*b)/bd
      if x.is_a?(Rational) && y.is_a?(Rational)
        return Rational.new(Sum.new(Product.new(x.numerator, y.denominator), Product.new(y.numerator, x.denominator)),
                            Product.new(x.denominator, y.denominator)).simplify
      end

      return x + y if !x.is_a?(Base) && !y.is_a?(Base)

      self.class.new(x, y)
    end
  end
end
