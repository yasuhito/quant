# frozen_string_literal: true

require 'symbo/expression'
require 'symbo/power'

module Symbo
  # シンボリックな積
  class Product < Expression
    using Symbo::Refinement

    attr_reader :operands

    def base
      self
    end

    def exponent
      1
    end

    def term
      if @operands.first.constant?
        Product.new(*@operands[1..-1])
      else
        self
      end
    end

    def const
      if @operands.first.constant?
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

    def ==(other)
      return false unless other.is_a?(Product)

      @operands == other.operands
    end

    def product?
      true
    end

    def sum?
      false
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

    def zero?
      false
    end

    def constant?
      false
    end

    protected

    def _simplify
      return UNDEFINED if @operands.include?(UNDEFINED) # SPRD-1
      return 0 if @operands.any?(&:zero?) # SPRD-2
      return @operands[0] if length == 1 # SPRD-3

      # SPRD-4
      v = simplify_rec(@operands)
      if v.size == 1 # SPRD4-1
        v[0]
      elsif v.size > 1 # SPRD4-2
        Product(*v)
      else # SPRD4-3
        1
      end
    end

    private

    # l = [u1, u2,...,un] be a non-empty list with n ≥ 2 non-zero ASAEs.
    # Returns a list with zero or more operands that satisfy the condition of
    # ASAE-4.
    def simplify_rec(l)
      if l.size == 2 && l.none?(&:product?) # SPRDREC-1
        if l.all?(&:constant?) # SPRDREC-1-1
          p = simplify_rational_number_expression(Product(*l))
          if p == 1
            []
          else
            [p]
          end
        elsif l[0] == 1 # SPRDREC-1-2
          [l[1]]
        elsif l[1] == 1
          [l[0]]
        elsif l[0].base == l[1].base && l[0].base != UNDEFINED # SPRDREC-1-3
          s = Sum(l[0].exponent, l[1].exponent).simplify
          p = Power(l[0].base, s).simplify
          if p == 1
            []
          else
            [p]
          end
        elsif l[1].compare(l[0]) # SPRDREC-1-4
          [l[1], l[0]]
        else # SPRDREC-1-5
          l
        end
      elsif l.size == 2 && l.any?(&:product?) # SPRDREC-2
        if l[0].product? && l[1].product? # SPRDREC-2-1
          merge_products l[0].operands, l[1].operands
        elsif l[0].product? # SPRDREC-2-2
          merge_products l[0].operands, [l[1]]
        else # SPRDREC-2-3
          merge_products [l[0]], l[1].operands
        end
      else # SPRDREC-3
        w = simplify_rec(l[1..-1])
        if l[0].product? # SPRDREC-3-1
          merge_products l[0].operands, w
        else # SPRDREC-3-2
          merge_products [l[0]], w
        end
      end
    end

    def merge_products(p, q)
      if q.empty? # MPRD-1
        p
      elsif p.empty? # MPRD-2
        q
      else # MPRD-3
        p1 = p[0]
        q1 = q[0]
        h = simplify_rec([p1, q1])
        if h.empty? # MPRD-3-1
          merge_products p[1..-1], q[1..-1]
        elsif h.size == 1 # MPRD-3-2
          h + merge_products(p[1..-1], q[1..-1])
        elsif h == [p1, q1] # MPRD-3-3
          [p1] + merge_products(p[1..-1], q)
        elsif h == [q1, p1] # MPRD-3-4
          [q1] + merge_products(p, q[1..-1])
        end
      end
    end
  end
end

def Product(*operands) # rubocop:disable Naming/MethodName
  Symbo::Product.new(*operands)
end
