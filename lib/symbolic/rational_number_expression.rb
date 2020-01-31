# frozen_string_literal: true

module Symbolic
  # Rational number arithmetic
  module RationalNumberExpression
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
      if u.is_a?(Integer)
        return u
      elsif u.is_a?(Fraction)
        if denominator_fun(u).zero?
          return UNDEFINED
        else
          return u
        end
      elsif u.operands.size == 1
        v = simplify_rational_number_expression_rec(u.operands[0])
        if v == UNDEFINED
          return UNDEFINED
        elsif u.is_a?(Sum)
          return v
        else
          raise "Not implemented yet: simplify_rational_number_expression_rec(#{u})"
        end
      elsif u.operands.size == 2
        if u.is_a?(Sum) || u.is_a?(Product)
          v = simplify_rational_number_expression_rec(u.operands[0])
          w = simplify_rational_number_expression_rec(u.operands[1])
          if v == UNDEFINED || w == UNDEFINED
            return UNDEFINED
          else
            return evaluate_sum(v, w) if u.is_a?(Sum)
            return evaluate_product(v, w) if u.is_a?(Product)

            raise "Not implemented yet u=#{u}, v=#{v}, w=#{w}"
          end
        elsif u.is_a?(Power)
          v = simplify_rational_number_expression_rec(u.operands[0])
          if v == UNDEFINED
            return UNDEFINED
          else
            return evaluate_power(v, u.operands[1])
          end
        end
      end

      raise "Not implemented yet: simplify_rational_number_expression_rec(#{u})"
    end

    # TODO: 分数の場合を実装 (p. 38)
    def simplify_rational_number(u)
      if u.is_a?(Integer)
        u
      elsif u.is_a?(Fraction)
        u
      end
    end

    def numerator_fun(v)
      return v if v.is_a?(Integer)
      return v.operands[0] if v.is_a?(Fraction)

      raise "Not implemented yet: numerator_fun(#{v})"
    end

    def denominator_fun(v)
      return v.operands[1] if v.is_a?(Fraction)

      raise "Not implemented yet: denominator_fun(#{v})"
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
                elsif v.is_a?(Integer) && w.is_a?(Fraction)
                  v * w.rational
                elsif v.is_a?(Fraction) && w.is_a?(Integer)
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
      r = v.rational + w.rational
      Fraction(r.numerator, r.denominator)
    end
  end
end
