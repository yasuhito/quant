# frozen_string_literal: true

require 'symbolic/refinement/integer'
require 'symbolic/refinement/symbol'

module Symbolic
  # Rational number arithmetic
  module RationalNumberExpression
    using Symbolic::Refinement

    private

    def simplify_rational_number_expression(u)
      v = simplify_rational_number_expression_rec(u)
      if v == UNDEFINED
        UNDEFINED
      else
        simplify_rational_number v
      end
    end

    def simplify_rational_number_expression_rec(u)
      if u.integer?
        u
      elsif u.fraction?
        if u.denominator.zero?
          UNDEFINED
        else
          u
        end
      elsif u.length == 1
        v = simplify_rational_number_expression_rec(u.operands[0])
        if v == UNDEFINED
          UNDEFINED
        elsif u.sum?
          v
        elsif u.diff?
          evaluate_product(-1, v)
        end
      elsif u.length == 2
        if u.sum? || u.product? || u.diff? || u.quot?
          v = simplify_rational_number_expression_rec(u.operands[0])
          w = simplify_rational_number_expression_rec(u.operands[1])
          if v == UNDEFINED || w == UNDEFINED
            UNDEFINED
          else
            if u.sum?
              evaluate_sum v, w
            elsif u.diff?
              evaluate_difference v, w
            elsif u.product?
              evaluate_product v, w
            elsif u.quot?
              evaluate_quotient v, w
            end
          end
        elsif u.power?
          v = simplify_rational_number_expression_rec(u.operands[0])
          if v == UNDEFINED
            UNDEFINED
          else
            evaluate_power(v, u.operands[1])
          end
        end
      end
    end

    # TODO: 分数の場合を実装 (p. 38)
    def simplify_rational_number(u)
      if u.is_a?(Integer)
        u
      elsif u.is_a?(Rational)
        u
      elsif u.fraction?
        u.rational
      end
    end

    def numerator_fun(v)
      return v if v.is_a?(Integer)
      return v.operands[0] if v.fraction?

      raise "Not implemented yet: numerator_fun(#{v})"
    end

    def evaluate_power(v, n)
      unless numerator_fun(v).zero?
        if n.positive?
          s = evaluate_power(v, n - 1)
          evaluate_product(s, v)
        elsif n.zero?
          1
        end
      end
    end

    # v, w are both constants
    def evaluate_product(v, w)
      product = if v.is_a?(Integer) && w.is_a?(Integer)
                  v * w
                elsif v.is_a?(Integer) && w.fraction?
                  v * w.rational
                elsif v.fraction? && w.is_a?(Integer)
                  v.rational * w
                else
                  v.rational * w.rational
                end

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

    def evaluate_sum(v, w)
      if v.fraction? && w.fraction?
        r = v.rational + w.rational
        Fraction(r.numerator, r.denominator)
      elsif v.integer? && w.integer?
        v + w
      else
        raise NotImplementedError
      end
    end

    def evaluate_difference(v, w)
      v.rational - w.rational
    end

    # TODO: 真面目に実装 (p. 42)
    def evaluate_quotient(v, w)
      if w.zero?
        UNDEFINED
      else
        v / w
      end
    end
  end
end
