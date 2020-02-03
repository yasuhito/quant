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
        if denominator_fun(u).zero?
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
          elsif u.operands[1].is_a?(Integer)
            evaluate_power(v, u.operands[1])
          else
            Power(v, u.operands[1])
          end
        end
      end
    end

    def simplify_rational_number(u)
      if u.is_a?(Integer)
        u
      elsif u.is_a?(Fraction) && u.operands.all?(&:integer?)
        n = u.operands[0]
        d = u.operands[1]
        if irem(n, d).zero?
          iquot(n, d)
        else
          g = integer_gcd(n, d)
          if d.positive?
            Fraction(iquot(n, g), iquot(d, g))
          else
            Fraction(iquot(-n, g), iquot(-d, g))
          end
        end
      else
        u
      end
    end

    def integer_gcd(a, b)
      a.gcd b
    end

    def iquot(a, b)
      r = Rational(a, b)
      if r.denominator == 1
        r.numerator
      else
        r
      end
    end

    def irem(a, b)
      a % b
    end

    def numerator_fun(v)
      return v if v.is_a?(Integer)
      return v.numerator if v.is_a?(Rational)

      if v.fraction?
        if v.operands.all?(&:integer?)
          return v.rational.numerator
        else
          return v.numerator
        end
      end

      raise NotImplementedError, "numerator_fun(#{v})"
    end

    def denominator_fun(v)
      return 1 if v.is_a?(Integer)
      return v.denominator if v.is_a?(Rational)

      if v.fraction?
        if v.operands.all?(&:integer?)
          return v.rational.denominator
        else
          return v.denominator
        end
      end

      raise NotImplementedError, "denominator_fun(#{v})"
    end

    # Returns v * w
    # (v, w are both constants)
    def evaluate_product(v, w)
      if v.is_a?(Integer) && w.is_a?(Integer)
        v * w
      elsif v.is_a?(Integer) && w.fraction?
        if denominator_fun(w) == 1
          numerator_fun(v) * numerator_fun(w)
        else
          Fraction(numerator_fun(v) * numerator_fun(w), denominator_fun(w))
        end
      elsif v.is_a?(Fraction) && w.is_a?(Integer)
        p = v.rational * w
        if denominator_fun(p) == 1
          numerator_fun(p)
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
      if numerator_fun(w).zero?
        UNDEFINED
      else
        Fraction(numerator_fun(v) * denominator_fun(w),
                 numerator_fun(w) * denominator_fun(v))
      end
    end

    def evaluate_power(v, n)
      if numerator_fun(v) != 0
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
      elsif numerator_fun(v).zero?
        raise NotImplementedError
      end
    end
  end
end
