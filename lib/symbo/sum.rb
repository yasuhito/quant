# frozen_string_literal: true

require 'symbo/expression'
require 'symbo/factorial'
require 'symbo/function'
require 'symbo/product'

module Symbo
  # シンボリックな和
  class Sum < Expression
    using Symbo

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   (:x + :y).base # => :x + :y
    def base
      dup
    end

    # べき指数
    #
    #   (:x + :y).exponent # => 1
    def exponent
      1
    end

    # :section: Basic Distributive Transformation Methods

    # 同類項の項部分
    #
    #   (:x + :y).term # => Product[:x + :y]
    def term
      Product[self]
    end

    # 同類項の定数部分
    #
    #   (:x + :y).const # => 1
    def const
      1
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手が和の場合
    # 最右のオペランドから順に compare していき、異なるものがあればそれで順序を決定する。
    # どちらかのオペランドがなくなれば、短いほうが左側。
    #
    #   (:a + :b).compare(:a + :c) # => true
    #   Sum[:a, :c, :d].compare(Sum[:b, :c, :d]) # => true
    #   (:c + :d).compare(Sum[:b, :c, :d]) # => true
    #
    # - 階乗、関数、シンボルの場合
    # 相手を単項の和にして比較
    #
    #   (1 + :x).compare(:y) # => true
    #
    # - それ以外の場合
    # 次のルールで比較
    #
    #   !other.compare(self)
    def compare(other)
      case other
      when Sum
        return @operands.last.compare(other.operands.last) if @operands.last != other.operands.last

        m = length
        n = other.length
        if [m, n].min >= 2
          0.upto([m, n].min - 2) do |j|
            return @operands[m - j - 2].compare(other.operand(n - j - 2)) if @operands[m - j - 1] == other.operand(n - j - 1) && @operands[m - j - 2] != other.operand(n - j - 2)
          end
        end

        m.compare(n)
      when Factorial, Function, Symbol
        compare Sum[other]
      else
        !other.compare(self)
      end
    end

    # :section: Expression Type Methods

    def sum?
      true
    end

    # :section:

    def evaluate
      v = @operands[0].evaluate

      if length == 1
        if v == UNDEFINED
          UNDEFINED
        else
          v
        end
      elsif length == 2
        w = @operands[1].evaluate

        if v == UNDEFINED || w == UNDEFINED
          UNDEFINED
        elsif v.fraction? && w.fraction?
          if v.denominator == w.denominator
            Fraction[Sum[v.numerator, w.numerator].simplify, v.denominator.simplify].simplify
          else
            Fraction[Sum[Product[v.numerator, w.denominator].evaluate, Product[w.numerator, v.denominator].evaluate].evaluate,
                     Product[v.denominator, w.denominator].evaluate].evaluate
          end
        elsif v.integer? && (w.integer? || w.is_a?(Complex))
          v.plus w
        elsif v.integer? && w.fraction?
          if v.zero?
            w
          else
            Sum[v, w]
          end
        else
          raise NotImplementedError, "evaluate(#{v.inspect}, #{w.inspect})"
        end
      end
    end

    def simplify_rational_number
      self
    end

    def to_s
      elements = @operands.map do |each|
        case each
        when Sum
          if each.length > 1
            [' + ', "(#{each})"]
          else
            [' + ', each.to_s]
          end
        when Product
          if each.length == 2 && each.operand(0) == -1
            [' - ', each.operand(1).to_s]
          else
            [' + ', "(#{each})"]
          end
        else
          [' + ', each.to_s]
        end
      end
      elements.flatten[1..-1].join
    end

    protected

    def _simplify
      return UNDEFINED if @operands.include?(UNDEFINED)
      return operand(0) if length == 1

      v = simplify_rec(@operands)
      if v.size == 1
        v[0]
      elsif v.size > 1
        Sum[*v]
      else
        0
      end
    end

    private

    def simplify_rec(l)
      if l.size == 2 && l.none?(&:sum?)
        if l.all?(&:constant?)
          p = Sum[*l].simplify_rne
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
          s = Sum[l[0].const, l[1].const].simplify
          p = Product[l[0].term, s].simplify

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

    def simplify_rne_rec
      if length == 1
        v = operand(0).simplify_rne_rec
        if v.undefined?
          UNDEFINED
        else
          v
        end
      elsif length == 2
        v = operand(0).simplify_rne_rec
        w = operand(1).simplify_rne_rec
        if v.undefined? || w.undefined?
          UNDEFINED
        else
          Sum[v, w].evaluate
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
