# frozen_string_literal: true

require 'symbolic/sqrt'

module Symbolic
  # サインのシンボリック演算
  class Sin
    attr_reader :x

    def initialize(x)
      @x = x
    end

    def simplify
      if @x.is_a?(Integer) && @x.zero?
        0
      elsif @x == Pi
        0
      elsif @x.is_a?(Numeric) && @x.negative?
        [:*, -1, Sin(-1 * @x)]
      elsif @x[0] == :* && @x[1].class == Rational && @x[2] == Pi &&
            [1, 2, 3, 4, 6].include?(@x[1].denominator) && @x[1].numerator.is_a?(Integer)
        simplify_kn_pi
      else
        self
      end
    end

    def -@
      [:*, -1, self]
    end

    def ==(other)
      @x == other.x
    end

    private

    # Simplification of sin(kπ/n)
    # k と n は整数, n = 1, 2, 3, 4, 6
    def simplify_kn_pi
      k = @x[1].numerator
      n = @x[1].denominator

      case n
      when 1
        0
      when 2
        case k % 4
        when 1
          1
        when 3
          -1
        end
      when 3
        case k % 6
        when 1, 2
          Rational(Sqrt(3), 2)
        when 4, 5
          Rational(-Sqrt(3), 2)
        end
      when 4
        case k % 8
        when 1, 3
          Rational(1, Sqrt(2))
        when 5, 7
          Rational(-1, Sqrt(2))
        end
      when 6
        case k % 12
        when 1, 5
          Rational(1, 2)
        when 7, 11
          Rational(-1, 2)
        end
      end
    end
  end
end

def Sin(x) # rubocop:disable Naming/MethodName
  Symbolic::Sin.new(x).simplify
end
