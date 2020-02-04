# frozen_string_literal: true

require 'symbo/refinement/integer'
require 'symbo/refinement/symbol'

module Symbo
  # Rational number arithmetic
  module RationalNumberExpression
    using Symbo::Refinement

    private

    def simplify_rational_number_expression(u)
      simplify_rational_number_expression_rec(u).simplify_rational_number
    end

    def simplify_rational_number_expression_rec(u)
      if u.integer?
        u.evaluate
      elsif u.fraction?
        u.evaluate
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
          elsif u.operands[1].is_a?(Integer)
            evaluate_power(v, u.operands[1])
          else
            Power(v, u.operands[1])
          end
        end
      end
    end

    # Returns v * w
    # (v, w are both constants)
    def evaluate_product(v, w)
      if v.is_a?(Integer) && w.is_a?(Integer)
        v * w
      elsif v.is_a?(Integer) && w.fraction?
        if w.denominator == 1
          v.numerator * w.numerator
        else
          Fraction v.numerator * w.numerator, w.denominator
        end
      elsif v.is_a?(Fraction) && w.is_a?(Integer)
        p = v.rational * w
        if p.denominator == 1
          p.numerator
        else
          p
        end
      elsif v.is_a?(Rational) && w.is_a?(Fraction)
        v * w.rational
      else
        raise NotImplementedError, "evaluate_product(#{v.inspect}, #{w.inspect})"
      end
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

    # evaluate v/w
    def evaluate_quotient(v, w)
      if w.numerator.zero?
        UNDEFINED
      else
        Fraction v.numerator * w.denominator, w.numerator * v.denominator
      end
    end

    def evaluate_power(v, n)
      if v.numerator != 0
        if n.positive?
          s = evaluate_power(v, n - 1)
          evaluate_product s, v
        elsif n.zero?
          1
        elsif n == -1
          raise NotImplementedError
        elsif n < -1
          raise NotImplementedError
        end
      elsif v.numerator.zero?
        raise NotImplementedError
      end
    end
  end
end
