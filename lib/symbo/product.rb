# frozen_string_literal: true

require 'quant/column_vector'
require 'symbo/expression'
require 'symbo/power'

module Symbo
  # シンボリックな積
  class Product < Expression
    using Symbo

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   (:x * :y).base # => :x * :y
    def base
      dup
    end

    # べき指数
    #
    #   (:x * :y).exponent # => 1
    def exponent
      1
    end

    # :section: Basic Distributive Transformation Methods

    # 同類項の項部分
    #
    #   Product[2, :x, :y, :z].term # => Product[:x, :y, :z]
    #   Product[1/3, :x, :y, :z].term # => Product[:x, :y, :z]
    #   Product[:x, :y, :z].term # => Product[:x, :y, :z]
    def term
      if @operands.first.constant?
        Product.new(*@operands[1..-1])
      else
        self
      end
    end

    # 同類項の定数部分
    #
    #   Product[2, :x, :y, :z].const # => 2
    #   Product[1/3, :x, :y, :z].const # => 1/3
    #   Product[:x, :y, :z].const # => 1
    def const
      if @operands.first.constant?
        @operands.first
      else
        1
      end
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手が積の場合
    # 最右のオペランドから順に compare していき、異なるものがあればそれで順序を決定する。
    #
    #   (:a * :b).compare(:a * :c) # => true
    #   Product[:a, :c, :d].compare(Product[:b, :c, :d]) # => true
    #
    # どちらかのオペランドがなくなれば、短いほうが左側。
    #
    #   (:c * :d).compare(Product[:b, :c, :d]) # => true
    #
    # - べき乗、和、階乗、関数、シンボルの場合
    # 相手を単項の積にして比較
    #
    #   (:a * (:x**2)).compare(:x**3) # => true
    #
    # - それ以外の場合
    # 次のルールで比較
    #
    #   !other.compare(self)
    #
    # rubocop:disable Metrics/CyclomaticComplexity
    def compare(other)
      case other
      when Product
        return @operands.last.compare(other.operands.last) if @operands.last != other.operands.last

        m = length
        n = other.length
        if [m, n].min >= 2
          0.upto([m, n].min - 2) do |j|
            return @operands[m - j - 2].compare(other.operand(n - j - 2)) if @operands[m - j - 1] == other.operand(n - j - 1) && @operands[m - j - 2] != other.operand(n - j - 2)
          end
        end

        m.compare n
      when Power, Sum, Factorial, Function, Symbol
        compare Product[other]
      else
        !other.compare(self)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity

    # :section: Expression Type Methods

    def product?
      true
    end

    # :section:

    # v * w
    #
    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def evaluate
      v = @operands[0]
      w = @operands[1]

      if v == UNDEFINED || w == UNDEFINED
        UNDEFINED
      elsif v.is_a?(Integer) && (w.is_a?(Integer) || w.is_a?(Complex))
        v.mult w
      elsif v.is_a?(Complex) && (w.is_a?(Integer) || w.is_a?(Complex))
        v.mult w
      elsif (v.is_a?(Integer) || v.is_a?(Complex)) && w.fraction?
        if w.denominator == 1
          v.numerator.mult w.numerator
        elsif w.numerator == 1
          Fraction[v, w.denominator]
        else
          Fraction[v.mult(w.numerator), w.denominator]
        end
      elsif v.is_a?(Fraction) && (w.is_a?(Integer) || w.is_a?(Complex))
        if v.numerator.integer? && v.denominator.integer?
          p = v.rational * w
          if p.denominator == 1
            p.numerator
          else
            Fraction[p.numerator, p.denominator]
          end
        else
          Fraction[(v.numerator * w).simplify, v.denominator]
        end
      elsif v.fraction? && w.fraction?
        Fraction[Product[v.numerator, w.numerator].simplify, Product[v.denominator, w.denominator].simplify].evaluate
      elsif v.power? && w.power?
        Product[v, w].simplify.evaluate
      else
        Product[v.simplify, w.simplify]
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def to_s
      if length == 2 && operand(0) == -1
        "-#{operand(1)}"
      else
        @operands.map do |each|
          case each
          when Sum
            "(#{each})"
          when Product
            if each.length == 2 && each.operand(0) == -1
              "(-#{each.operand(1)})"
            elsif each.length > 1
              "(#{each})"
            else
              each.to_s
            end
          else
            each.to_s
          end
        end.join('*')
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    protected

    def _simplify
      return UNDEFINED if @operands.any?(&:undefined?)
      return 0 if @operands.any?(&:zero?)
      return operand(0) if length == 1

      v = simplify_rec(@operands)
      if v.size == 1
        v[0]
      elsif v.size > 1
        Product[*v]
      else
        1
      end
    end

    private

    # l = [u1, u2,...,un] be a non-empty list with n ≥ 2 non-zero ASAEs.
    # Returns a list with zero or more operands that satisfy the condition of
    # ASAE-4.
    #
    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def simplify_rec(l) # rubocop:disable Naming/MethodParameterName
      u1 = l[0]
      u2 = l[1]

      if l.size == 2 && l.none?(&:product?) # SPRDREC-1
        if l.all?(&:constant?) # SPRDREC-1-1
          p = Product[*l].simplify_rne
          p == 1 ? [] : [p]
        elsif u1 == 1 # SPRDREC-1-2
          [u2]
        elsif u2 == 1
          [u1]
        elsif u1.base == u2.base # SPRDREC-1-3
          s = Sum[u1.exponent, u2.exponent].simplify
          p = Power[u1.base, s].simplify
          p == 1 ? [] : [p]
        elsif u2.compare(u1) # SPRDREC-1-4
          [u2, u1]
        else # SPRDREC-1-5
          l
        end
      elsif l.size == 2 && l.any?(&:product?) # SPRDREC-2
        if u1.product? && u2.product? # SPRDREC-2-1
          merge_products u1.operands, u2.operands
        elsif u1.product? # SPRDREC-2-2
          merge_products u1.operands, [u2]
        else # SPRDREC-2-3
          merge_products [u1], u2.operands
        end
      else # SPRDREC-3
        w = simplify_rec(l[1..-1])
        if u1.product? # SPRDREC-3-1
          merge_products u1.operands, w
        else # SPRDREC-3-2
          merge_products [u1], w
        end
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    def simplify_rne_rec
      raise unless length == 2

      v = operand(0).simplify_rne_rec
      w = operand(1).simplify_rne_rec

      if v.undefined? || w.undefined?
        UNDEFINED
      else
        Product[v, w].evaluate
      end
    end

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def merge_products(p, q) # rubocop:disable Naming/MethodParameterName
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
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity
  end
end
