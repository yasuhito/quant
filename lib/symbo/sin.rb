# frozen_string_literal: true

require 'symbo/trigonometric_function'

module Symbo
  # サインのシンボリック演算
  class Sin < TrigonometricFunction
    using Symbo

    def initialize(x)
      super :sin, x
    end

    # FIXME
    def compare(_other)
      false
    end

    protected

    def _simplify
      if x.zero?
        0
      elsif x == PI
        0
      elsif x.constant? && x.negative?
        -Sin(-1.mult(x))
      elsif x.product? && x.operand(0).integer? && x.operand(0).negative?
        (-Sin(Product(-1, x.operand(0), *x.operands[1..-1]).simplify)).simplify
      elsif x.product? && x.length == 2 && x.operand(0).constant? && x.operand(1) == PI &&
            [1, 2, 3, 4, 6].include?(x.operand(0).denominator) && x.operand(0).numerator.integer?
        simplify_kn_pi x.operand(0).numerator, x.operand(0).denominator
      else
        self
      end
    end

    private

    # Simplification of sin(kπ/n)
    # k と n は整数, n = 1, 2, 3, 4, 6
    def simplify_kn_pi(k, n)
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
          √(3)/2
        when 4, 5
          Product(-1, √(3)/2)
        end
      when 4
        case k % 8
        when 1, 3
          1/√(2)
        when 5, 7
          -1/√(2)
        end
      when 6
        case k % 12
        when 1, 5
          1/2
        when 7, 11
          -1/2
        end
      end
    end
  end
end

def Sin(x) # rubocop:disable Naming/MethodName
  Symbo::Sin.new(x)
end
