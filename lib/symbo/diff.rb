# frozen_string_literal: true

require 'symbo/expression'

module Symbo
  # Symbolic difference
  class Diff < Expression
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
      true
    end

    def evaluate
      v = simplify_rational_number_expression_rec(@operands[0])
      w = simplify_rational_number_expression_rec(@operands[1])

      if v == UNDEFINED || w == UNDEFINED
        UNDEFINED
      else
        v.rational - w.rational
      end
    end
  end
end

def Diff(*operands) # rubocop:disable Naming/MethodName
  Symbo::Diff.new(*operands)
end
