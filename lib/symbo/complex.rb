# frozen_string_literal: true

require 'symbo/expression_type'

module Symbo
  refine Complex do
    include AlgebraicOperators
    include ExpressionType

    def simplify
      dup
    end

    def constant?
      true
    end

    def evaluate
      dup
    end

    def simplify_rational_number
      dup
    end

    def simplify_rne_rec
      dup
    end

    def base
      UNDEFINED
    end

    def compare(other)
      case other
      when Integer
        false
      else
        true
      end
    end
  end
end

# Matrix などの中で使われる Complex#+ などをハイジャック
class Complex
  alias plus +
  alias mult *

  def +(other)
    plus other
  rescue TypeError
    Symbo::Sum[self, other]
  end

  def *(other)
    mult other
  rescue TypeError
    Symbo::Product[self, other]
  end
end
