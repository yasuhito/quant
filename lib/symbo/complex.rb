# frozen_string_literal: true

module Symbo
  refine Complex do
    def simplify
      dup
    end

    def product?
      false
    end

    def constant?
      true
    end

    def fraction?
      false
    end

    def sum?
      false
    end

    def evaluate
      self
    end

    def simplify_rational_number
      self
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
