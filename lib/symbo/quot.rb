# frozen_string_literal: true

require 'symbo/expression'

module Symbo
  # Symbolic quotient
  class Quot < Expression
    using Symbo

    def integer?
      false
    end

    def fraction?
      false
    end

    def sum?
      false
    end

    def product?
      false
    end

    def diff?
      false
    end

    def quot?
      true
    end

    def evaluate
      v = @operands[0].evaluate
      w = @operands[1].evaluate

      if v == UNDEFINED || w == UNDEFINED
        UNDEFINED
      elsif w.numerator.zero?
        UNDEFINED
      else
        Fraction v.numerator * w.denominator, w.numerator * v.denominator
      end
    end
  end
end

def Quot(*operands) # rubocop:disable Naming/MethodName
  Symbo::Quot.new(*operands)
end
