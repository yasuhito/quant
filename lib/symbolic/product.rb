# frozen_string_literal: true

require 'symbolic/rational_number_expression'
require 'symbolic/refinement/integer'
require 'symbolic/refinement/symbol'

module Symbolic
  # シンボリックな積
  class Product
    using Symbolic::Refinement

    include RationalNumberExpression

    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    def simplify
      Product.new(*@operands.map(&:simplify)).simplify_product
    end

    def simplify_product
      return :Undefined if @operands.include?(:Undefined)
      return 0 if @operands.any?(&:zero?)
      return @operands[0] if @operands.size == 1

      v = simplify_product_rec(@operands)
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
      if l.size == 2 && l.none? { |each| each.is_a?(Product) }
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
          s = simplify_sum(Sum(l[0].exponent, l[1].exponent))
          p = Power(l[0].base, s).simplify
          if p == 1
            []
          else
            [p]
          end
        elsif l[1].compare(l[0])
          [l[1], l[0]]
        else
          l
        end
      elsif l.size == 2 && l.any? { |each| each.is_a?(Product) }
        if l[0].is_a?(Product) && !l[1].is_a?(Product)
          merge_products l[0].operands, [l[1]]
        else
          raise "Not implemented yet: simplify_product_rec(#{l})"
        end
      elsif l.size > 2
        w = simplify_product_rec(l[1..-1])
        if l[0].is_a?(Product)
          raise "Not implemented yet: simplify_product_rec(#{l})"
        else
          merge_products([l[0]], w)
        end
      else
        raise "Not implemented yet: simplify_product_rec(#{l})"
      end
    end

    # TODO: sum.rb に移動
    def simplify_sum(u)
      if u.operands.size == 2 && u.operands[0].is_a?(Integer) && u.operands[1].is_a?(Integer)
        u.operands[0] + u.operands[1]
      else
        raise "Not implemented yet: simplify_sum(#{u})"
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
          h + merge_products(p[1..-1], q[1..-1])
        elsif h == [p1, q1]
          [p1] + merge_products(p[1..-1], q)
        elsif h == [q1, p1]
          [q1] + merge_products(p, q[1..-1])
        else
          raise "Not implemented yet: merge_products(#{p}, #{q})"
        end
      end
    end

    def base
      self
    end

    def exponent
      1
    end

    def term
      if @operands.first.is_a?(Integer) || @operands.first.is_a?(Fraction)
        Product.new(*@operands[1..-1])
      else
        self
      end
    end

    def const
      if @operands.first.is_a?(Integer) || @operands.first.is_a?(Fraction)
        @operands.first
      else
        1
      end
    end

    def compare(v)
      case v
      when Product
        return @operands.last.compare(v.operands.last) if @operands.last != v.operands.last

        m = length
        n = v.length
        if [m, n].min >= 2
          0.upto([m, n].min - 2) do |j|
            return @operands[m - j - 2].compare(v[n - j - 2]) if @operands[m - j - 1] == v[n - j - 1] && @operands[m - j - 2] != v[n - j - 2]
          end
        end

        m.compare(n)
      when Power, Sum, Factorial, Function, Symbol
        compare Product(v)
      end
    end

    def length
      @operands.length
    end

    def [](n)
      @operands[n]
    end

    def ==(other)
      return false unless other.is_a?(Product)

      @operands == other.operands
    end

    # TODO: 後で実装
    def zero?
      false
    end
  end
end

def Product(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Product.new(*operands)
end
