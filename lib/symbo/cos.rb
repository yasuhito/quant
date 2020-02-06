# frozen_string_literal: true

require 'symbo/trigonometric_function'

module Symbo
  # Symbo cos(x)
  class Cos < TrigonometricFunction
    using Symbo

    protected

    def _simplify
      if @x.zero?
        1
      elsif @x == PI
        -1
      elsif @x.constant? && @x.negative?
        Cos(Product(-1, @x).simplify)
      elsif @x.product? && @x.operand(0).integer? && @x.operand(0).negative?
        Cos(Product(-1, @x.operand(0), *@x.operands[1..-1]).simplify).simplify
      elsif @x.product? && @x.length == 2 && @x.operand(0).constant? && @x.operand(1) == PI &&
            [1, 2, 3, 4, 6].include?(@x.operand(0).denominator) && @x.operand(0).numerator.integer?
        simplify_kn_pi
      else
        self
      end
    end

    private

    # Simplification of cos(kπ/n)
    def simplify_kn_pi
      k = @x.operand(0).numerator
      n = @x.operand(0).denominator

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
          1/√(2)
        when 3, 5
          -1/√(2)
        end
      when 6
        case k % 12
        when 1, 11
          √(3)/2
        when 5, 7
          Product(-1, √(3)/2)
        end
      end
    end
  end
end

def Cos(x) # rubocop:disable Naming/MethodName
  Symbo::Cos.new(x)
end
