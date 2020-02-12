# frozen_string_literal: true

require 'symbo/expression_type'

module Symbo
  refine Complex do
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
  end
end

# Matrix などの中で使われる Complex#+ などをハイジャック
class Complex
  alias plus +
  alias mult *

  def +(other)
    plus other
  rescue TypeError
    Sum self, other
  end

  def *(other)
    mult other
  rescue TypeError
    Product self, other
  end
end
