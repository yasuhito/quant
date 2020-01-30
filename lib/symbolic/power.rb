# frozen_string_literal: true

require 'symbolic/rational_number_expression'
require 'symbolic/refinement/integer'
require 'symbolic/refinement/symbol'

module Symbolic
  # シンボリックなべき乗
  class Power
    using Symbolic::Refinement

    include RationalNumberExpression

    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    def simplify
      Power.new(*@operands.map(&:simplify)).simplify_power
    end

    def simplify_power
      return :Undefined if base == :Undefined || exponent == :Undefined

      if base.zero?
        return 1 if exponent.is_a?(Integer) && exponent.positive?
        return 1 if exponent.is_a?(Fraction) && exponent.positive?

        return :Undefined
      end

      return 1 if base == 1
      return simplify_integer_power if exponent.is_a?(Integer)

      self
    end

    def simplify_integer_power
      return simplify_rational_number_expression(Power.new(base, exponent)) if base.is_a?(Integer) || base.is_a?(Fraction)
      return 1 if exponent.zero?
      return base if exponent == 1

      if base.is_a?(Power)
        r = base.operands[0]
        s = base.operands[1]
        p = Product.new(s, exponent).simplify_product

        if p.is_a?(Integer)
          Power.new(r, p).simplify_integer_power
        else
          Power.new(r, p)
        end
      elsif base.is_a?(Product)
        Product(*(base.operands.map { |each| Power.new(each, exponent).simplify_integer_power })).simplify_product
      else
        self
      end
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

    def zero?
      false
    end

    private

    def [](n)
      @operands[n]
    end
  end
end

def Power(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Power.new(*operands)
end
