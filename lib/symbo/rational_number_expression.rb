# frozen_string_literal: true

module Symbo
  # Rational number arithmetic
  module RationalNumberExpression
    using Symbo

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
          u.evaluate
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

    def evaluate_power(v, n)
      if v.numerator != 0
        if n.positive?
          s = evaluate_power(v, n - 1)
          Product(s, v).evaluate
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
