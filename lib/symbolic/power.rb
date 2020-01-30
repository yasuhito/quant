# frozen_string_literal: true

require 'symbolic/refinement/integer'
require 'symbolic/refinement/symbol'

module Symbolic
  # シンボリックなべき乗
  class Power
    using Symbolic::Refinement

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
      return simplify_integer_power(base, exponent) if exponent.is_a?(Integer)

      self
    end

    def simplify_integer_power(v, n)
      return simplify_rne(Power.new(v, n)) if v.is_a?(Integer) || v.is_a?(Fraction)
      return 1 if n.zero?
      return v if n == 1
      return Power(v, n) if v.is_a?(Symbol)

      r = v.operands[0]
      s = v.operands[1]
      p = simplify_product(Power.new(s, n))

      if p.is_a?(Integer)
        simplify_integer_power(r, p)
      else
        Power.new(r, p)
      end
    end

    def simplify_product(u)
      return u.operands[0] if u.operands.size == 1

      v = simplify_product_rec(u.operands)
    end

    # Let L = [u1, u2,...,un] be a non-empty list with n ≥ 2 non-zero ASAEs.
    # The operator Simplify product rec(L) (for "Simplify product recursive")
    # returns a list with zero or more operands.
    def simplify_product_rec(l)
      p = simplify_rne(Product(*l))
    end

    # RNE = rational number expression
    def simplify_rne(u)
      v = simplify_rne_rec(u)
      if v == :Undefined
        :Undefined
      else
        simplify_rational_number v
      end
    end

    def simplify_rne_rec(u)
      if u.is_a?(Integer)
        return u
      elsif u.is_a?(Fraction)
        if denominator_fun(u).zero?
          return :Undefined
        else
          return u
        end
      elsif u.operands.size == 2
        if u.is_a?(Product)
          v = simplify_rne_rec(u.operands[0])
          w = simplify_rne_rec(u.operands[1])
          if v == :Undefined || w == :Undefined
            return :Undefined
          else
            if u.is_a?(Product)
              return evaluate_product(v, w)
            end

            raise "Not implemented yet u=#{u}, v=#{v}, w=#{w}"
          end
        elsif u.is_a?(Power)
          v = simplify_rne_rec(@operands[0])
          if v == :Undefined
            return :Undefined
          else
            return evaluate_power(v, @operands[1])
          end
        end
      end

      raise "Not implemented yet: simplify_rne_rec(#{u})"
    end

    def simplify_rational_number(u)
      return u if u.is_a?(Integer)
    end

    def evaluate_power(v, n)
      if !numerator_fun(v).zero?
        if n > 0
          s = evaluate_power(v, n - 1)
          evaluate_product(s, v)
        elsif n.zero?
          1
        end
      end
    end

    def numerator_fun(v)
      return v if v.is_a?(Integer)
    end

    def denominator_fun(v)
      return v.operands[1] if v.is_a?(Fraction)

      raise "Not implemented yet: denominator_fun(#{v})"
    end

    # v, w are both constants
    def evaluate_product(v, w)
      product = v * w
      if product.is_a?(Integer)
        return product
      elsif product.is_a?(Rational)
        if product.denominator == 1
          return product.numerator
        else
          return product
        end
      end

      raise "Not implemented yet: evaluate_product(#{v}, #{w})"
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
        compare Power(v, 1)
      end
    end

    def [](n)
      @operands[n]
    end

    def ==(other)
      return false unless other.is_a?(Power)

      @operands == other.operands
    end

    def zero?
      false
    end
  end
end

def Power(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Power.new(*operands)
end
