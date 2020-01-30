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

      if v.is_a?(Power)
        r = v.operands[0]
        s = v.operands[1]
        p = simplify_product(Power.new(s, n))

        if p.is_a?(Integer)
          simplify_integer_power(r, p)
        else
          Power.new(r, p)
        end
      elsif v.is_a?(Product)
        simplify_product Product(*(v.operands.map { |each| Power(each, n).simplify_integer_power(each, n) }))
      else
        Power(v, n)
      end
    end

    def simplify_product(u)
      return :Undefined if u.operands.include?(:Undefined)
      return 0 if u.operands.any?(&:zero?)
      return u.operands[0] if u.operands.size == 1

      v = simplify_product_rec(u.operands)
      if v.size == 1
        v[0]
      elsif v.size > 1
        Product(*v)
      else
        1
      end
    end

    # Let L = [u1, u2,...,un] be a non-empty list with n ≥ 2 non-zero ASAEs.
    # The operator Simplify product rec(L) (for "Simplify product recursive")
    # returns a list with zero or more operands.
    def simplify_product_rec(l)
      if l.size == 2 && !l.any? { |each| each.is_a?(Product) }
        if (l[0].is_a?(Integer) || l[0].is_a?(Fraction)) && (l[1].is_a?(Integer) || l[1].is_a?(Fraction))
          p = simplify_rne(Product(*l))
          if p == 1
            []
          else
            [p]
          end
        elsif l[0] == 1
          [l[1]]
        elsif l[1] == 1
          [l[0]]
        elsif l[0].base == l[1].base
          raise "Not implemented yet: simplify_product_rec(#{l})"
        elsif l[1].compare(l[1])
          raise "Not implemented yet: simplify_product_rec(#{l})"
        else
          l
        end
      elsif l.size == 2 && l.any? { |each| each.is_a?(Product) }
        if l[0].is_a?(Product) && !l[1].is_a?(Product)
          merge_products l[0].operands, [l[1]]
        else
          raise "Not implemented yet: simplify_product_rec(#{l})"
        end
      else
        raise "Not implemented yet: simplify_product_rec(#{l})"
      end
    end

    def merge_products(p, q)
      if q.empty?
        p
      elsif p.empty?
        q
      else
        p1 = p[0]
        q1 = q[0]
        h = simplify_product_rec([p1, q1])
        if h.empty?
          merge_products p[1..-1], q[1..-1]
        elsif h.size == 1
          raise "Not implemented yet: merge_products(#{p}, #{q})"
        elsif h == [p1, q1]
          [p1] + merge_products(p[1..-1], q)
        elsif h == [q1, p1]
          raise "Not implemented yet: merge_products(#{p}, #{q})"
        else
          raise "Not implemented yet: merge_products(#{p}, #{q})"
        end
      end
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
