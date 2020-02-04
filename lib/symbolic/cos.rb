# frozen_string_literal: true

require 'symbolic/trigonometric_function'

module Symbolic
  # Symbolic cos(x)
  class Cos < TrigonometricFunction
    using Symbolic::Refinement

    protected

    def _simplify
      if @x.zero?
        1
      elsif @x == PI
        -1
      elsif @x.constant? && @x.negative?
        Cos(Product(-1, @x).simplify)
      elsif @x.product? && @x[0].integer? && @x[0].negative?
        Cos(Product(-1, @x[0], *@x.operands[1..-1]).simplify).simplify
      elsif @x.product? && @x.length == 2 && @x[0].constant? && @x[1] == PI &&
            [1, 2, 3, 4, 6].include?(@x[0].denominator) && @x[0].numerator.integer?
        simplify_kn_pi
      else
        self
      end
    end

    private

    # Simplification of cos(kπ/n)
    def simplify_kn_pi
      k = @x[0].numerator
      n = @x[0].denominator

      case n
      when 1
        case k % 2
        when 0
          1
        when 1
          -1
        end
      when 2
        case k % 2
        when 1
          0
        end
      when 3
        case k % 6
        when 1, 5
          1/2
        when 2, 4
          -1/2
        end
      when 4
        case k % 8
        when 1, 7
          1/Sqrt(2)
        when 3, 5
          -1/Sqrt(2)
        end
      when 6
        case k % 12
        when 1, 11
          Fraction(Sqrt(3), 2)
        when 5, 7
          Product(-1, Fraction(Sqrt(3), 2))
        end
      end
    end
  end
end

def Cos(x) # rubocop:disable Naming/MethodName
  Symbolic::Cos.new(x)
end
