# frozen_string_literal: true

require 'symbolic/expression'
require 'symbolic/factorial'
require 'symbolic/function'
require 'symbolic/product'

module Symbolic
  # シンボリックな和
  class Sum < Expression
    using Symbolic::Refinement

    def base
      self
    end

    def exponent
      1
    end

    def term
      Product(self)
    end

    def const
      1
    end

    def compare(v)
      case v
      when Sum
        return @operands.last.compare(v.operands.last) if @operands.last != v.operands.last

        m = length
        n = v.length
        if [m, n].min >= 2
          0.upto([m, n].min - 2) do |j|
            return @operands[m - j - 2].compare(v[n - j - 2]) if @operands[m - j - 1] == v[n - j - 1] && @operands[m - j - 2] != v[n - j - 2]
          end
        end

        m.compare(n)
      when Factorial, Function, Symbol
        compare Sum(v)
      end
    end

    def sum?
      true
    end

    def integer?
      false
    end

    def fraction?
      false
    end

    def ==(other)
      other.is_a?(Sum) && @operands == other.operands
    end

    protected

    def _simplify
      return UNDEFINED if @operands.include?(UNDEFINED)
      return @operands[0] if length == 1

      v = simplify_rec(@operands)
      if v.size == 1
        v[0]
      elsif v.size > 1
        Sum(*v)
      else
        0
      end
    end

    private

    def simplify_rec(l)
      if l.size == 2 && l.none?(&:sum?)
        if l.all?(&:constant?)
          p = simplify_rational_number_expression(Sum(*l))
          if p.zero?
            []
          else
            [p]
          end
        elsif l[0].zero?
          [l[1]]
        elsif l[1].zero?
          [l[0]]
        elsif l[0].term == l[1].term
          s = Sum(l[0].const, l[1].const).simplify
          p = Product(l[0].term, s).simplify
          if p.zero?
            []
          else
            [p]
          end
        elsif l[1].compare(l[0])
          [l[1], l[0]]
        else
          l
        end
      elsif l.size == 2 && l.any?(&:sum?)
        if l[0].sum? && l[1].sum?
          merge_sums l[0].operands, l[1].operands
        elsif l[0].sum?
          merge_sums l[0].operands, [l[1]]
        else
          merge_sums [l[0]], l[1].operands
        end
      else
        w = simplify_rec(l[1..-1])
        if l[0].sum?
          merge_sums l[0].operands, w
        else
          merge_sums [l[0]], w
        end
      end
    end

    def merge_sums(p, q)
      if q.empty?
        p
      elsif p.empty?
        q
      else
        p1 = p[0]
        q1 = q[0]
        h = simplify_rec([p1, q1])
        if h.empty?
          merge_sums p[1..-1], q[1..-1]
        elsif h.size == 1
          h + merge_sums(p[1..-1], q[1..-1])
        elsif h == [p1, q1]
          [p1] + merge_sums(p[1..-1], q)
        elsif h == [q1, p1]
          [q1] + merge_sums(p, q[1..-1])
        end
      end
    end
  end
end

def Sum(*operands) # rubocop:disable Naming/MethodName
  Symbolic::Sum.new(*operands)
end
