# frozen_string_literal: true

require 'symbolic/expression'

module Symbolic
  # シンボリックなべき乗
  class Power < Expression
    using Symbolic::Refinement

    def /(other)
      Fraction self, other
    end

    def base
      @operands[0]
    end

    def exponent
      @operands[1]
    end

    def term
      Product(self)
    end

    def const
      1
    end

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

    def constant?
      false
    end

    def product?
      false
    end

    def sum?
      false
    end

    def power?
      true
    end

    def integer?
      false
    end

    def fraction?
      false
    end

    def diff?
      false
    end

    def quot?
      false
    end

    def zero?
      false
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
      return simplify_rational_number_expression(Power.new(base, exponent)) if base.constant?
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
  Symbolic::Power.new(*operands)
end
