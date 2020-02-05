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

    def evaluate
      self
    end

    def simplify_rational_number
      self
    end
  end
end
