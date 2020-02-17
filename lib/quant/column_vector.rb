# frozen_string_literal: true

require 'quant/vector'

module Quant
  class ColumnVector < Vector
    include Symbo

    using Symbo

    def +(other)
      elements = ((@elements.zip other.to_a).map { |each| each.inject(:+) })
      ColumnVector.new(*elements).simplify
    end

    def to_matrix
      Matrix[*(@elements.map { |each| [each.simplify] })]
    end

    def simplify
      ColumnVector.new(*@elements.map(&:simplify))
    end

    def length
      Sqrt(Sum[*(@elements.map { |each| Power(each, 2) })]).simplify
    end

    def undefined?
      false
    end

    def zero?
      false
    end

    def product?
      false
    end

    def constant?
      false
    end

    def base
      self
    end

    def compare(_other)
      false
    end

    def map(&block)
      ColumnVector.new(*@elements.map(&block))
    end
  end
end
