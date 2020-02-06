# frozen_string_literal: true

require 'symbo/expression'

module Symbo
  # シンボリックなべき乗
  class Power < Expression
    using Symbo

    # :section: Power Transformation Methods

    # See Symbo::Expression#base
    def base
      @operands[0]
    end

    # See Symbo::Expression#exponent
    def exponent
      @operands[1]
    end

    # :section: Basic Distributive Transformation Methods

    # See Symbo::Expression#term
    def term
      Product(self)
    end

    # See Symbo::Expression#const
    def const
      1
    end

    # :section:

    def compare(v)
      case v
      when Power
        return base.compare(v.base) if base != v.base

        exponent.compare(v.exponent)
      when Sum, Factorial, Function, Symbol
        compare Power.new(v, 1)
      end
    end

    def ==(other)
      return false unless other.is_a?(Power)

      @operands == other.operands
    end

    def evaluate
      v = base.evaluate
      n = exponent

      if v.numerator != 0
        if n.positive?
          s = Power(v, n - 1).evaluate
          Product(s, v).evaluate
        elsif n.zero?
          1
        elsif n == -1
          raise NotImplementedError
        elsif n < -1
          raise NotImplementedError
        end
      elsif v.numerator.zero?
        if n >= 1
          0
        elsif n <= 0
          UNDEFINED
        end
      end
    end

    protected

    def _simplify
      return UNDEFINED if base == UNDEFINED || exponent == UNDEFINED

      if base.zero?
        return 1 if exponent.is_a?(Integer) && exponent.positive?
        return 1 if exponent.is_a?(Fraction) && exponent.positive?

        return UNDEFINED
      end

      return 1 if base == 1
      return simplify_integer if exponent.is_a?(Integer)

      self
    end

    def simplify_integer
      return Power.new(base, exponent).evaluate.simplify_rational_number if base.constant?
      return 1 if exponent.zero?
      return base if exponent == 1

      if base.is_a?(Power)
        r = base.operands[0]
        s = base.operands[1]
        p = Product.new(s, exponent).simplify

        if p.is_a?(Integer)
          Power.new(r, p).simplify_integer
        else
          Power.new(r, p)
        end
      elsif base.is_a?(Product)
        Product(*(base.operands.map { |each| Power.new(each, exponent).simplify_integer })).simplify
      else
        self
      end
    end
  end
end

def Power(*operands) # rubocop:disable Naming/MethodName
  Symbo::Power.new(*operands)
end
