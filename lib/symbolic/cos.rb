# frozen_string_literal: true

require 'symbolic/refinement/integer'
require 'symbolic/refinement/symbol'

module Symbolic
  # コサインのシンボリック演算
  class Cos
    using Symbolic::Refinement

    attr_reader :x

    def initialize(x)
      @x = x
    end

    def simplify
      Cos.new(@x.simplify)._simplify
    end

    def ==(other)
      @x == other.x
    end

    protected

    def _simplify
      if @x.constant? && @x.zero?
        1
      elsif @x == PI
        0
      elsif @x.constant? && @x.negative?
        Cos(Product(-1, @x).simplify)
      # elsif @x.product? && @x[0].integer? && @x[0].negative?
      #   Cos(([-1, @x[1]] + @x[2..-1]).inject(:*))
      elsif @x.product? && @x.length == 2 && @x[0].fraction? && @x[1] == PI &&
            [1, 2, 3, 4, 6].include?(@x[0].denominator) && @x[0].numerator.integer?
        simplify_kn_pi
      else
        self
      end
    end

    private

    # Simplification of cos(kπ/n)
    # k と n は整数, n = 1, 2, 3, 4, 6
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
          Fraction(1, 2)
        when 2, 4
          Product(-1, Fraction(1, 2)).simplify
        end
      when 4
        case k % 8
        when 1, 7
          Fraction(1, Power(2, Fraction(1, 2))).simplify
        when 3, 5
          Product(-1, Fraction(1, Power(2, Fraction(1, 2)))).simplify
        end
      when 6
        case k % 12
        when 1, 11
          Fraction(Power(3, Fraction(1, 2)), 2)
        when 5, 7
          Product(-1, Fraction(Power(3, Fraction(1, 2)), 2))
        end
      end
    end
  end
end

def Cos(x) # rubocop:disable Naming/MethodName
  Symbolic::Cos.new(x)
end
