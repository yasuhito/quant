# frozen_string_literal: true

module Symbo
  module BinaryOperation
    def +(other)
      Sum self, other
    end

    def *(other)
      Product self, other
    end

    def /(other)
      Fraction self, other
    end

    def **(other)
      Power self, other
    end
  end
end
