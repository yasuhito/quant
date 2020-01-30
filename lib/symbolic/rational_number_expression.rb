# frozen_string_literal: true

module Symbolic
  module RationalNumberExpression
    private

    def simplify_rne(u)
      v = simplify_rne_rec(u)
      if v == :Undefined
        :Undefined
      else
        simplify_rational_number v
      end
    end

    def simplify_rne_rec(u)
      if u.is_a?(Integer)
        return u
      elsif u.is_a?(Fraction)
        if denominator_fun(u).zero?
          return :Undefined
        else
          return u
        end
      elsif u.operands.size == 2
        if u.is_a?(Product)
          v = simplify_rne_rec(u.operands[0])
          w = simplify_rne_rec(u.operands[1])
          if v == :Undefined || w == :Undefined
            return :Undefined
          else
            return evaluate_product(v, w) if u.is_a?(Product)

            raise "Not implemented yet u=#{u}, v=#{v}, w=#{w}"
          end
        elsif u.is_a?(Power)
          v = simplify_rne_rec(@operands[0])
          if v == :Undefined
            return :Undefined
          else
            return evaluate_power(v, @operands[1])
          end
        end
      end

      raise "Not implemented yet: simplify_rne_rec(#{u})"
    end

    def simplify_rational_number(u)
      return u if u.is_a?(Integer)
    end

    def numerator_fun(v)
      return v if v.is_a?(Integer)
    end

    def denominator_fun(v)
      return v.operands[1] if v.is_a?(Fraction)

      raise "Not implemented yet: denominator_fun(#{v})"
    end

    def evaluate_power(v, n)
      unless numerator_fun(v).zero?
        if n > 0
          s = evaluate_power(v, n - 1)
          evaluate_product(s, v)
        elsif n.zero?
          1
        end
      end
    end

    # v, w are both constants
    def evaluate_product(v, w)
      product = v * w
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
  end
end
