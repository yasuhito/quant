# frozen_string_literal: true

require 'symbolic/sqrt'

module Symbolic
  # コサインのシンボリック演算
  class Cos
    def initialize(x)
      @x = x
    end

    def simplify
      if @x.is_a?(Integer) && @x.zero?
        1
      elsif @x == Pi
        0
      elsif @x[0] == :* && @x[1].class == Rational && @x[2] == Pi &&
            [1, 2, 3, 4, 6].include?(@x[1].denominator) && @x[1].numerator.is_a?(Integer)
        simplify_kn_pi
      end
    end

    private

    # Simplification of cos(kπ/n)
    # k と n は整数, n = 1, 2, 3, 4, 6
    def simplify_kn_pi
      k = @x[1].numerator
      n = @x[1].denominator

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
          Rational(1, 2)
        when 2, 4
          Rational(-1, 2)
        end
      when 4
        case k % 8
        when 1, 7
          Rational(1, Sqrt(2))
        when 3, 5
          Rational(-1, Sqrt(2))
        end
      when 6
        case k % 12
        when 1, 11
          Rational(Sqrt(3), 2)
        when 5, 7
          Rational(-Sqrt(3), 2)
        end
      end
    end
  end
end

def Cos(x) # rubocop:disable Naming/MethodName
  Symbolic::Cos.new(x).simplify
end
