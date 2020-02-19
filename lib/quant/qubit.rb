# frozen_string_literal: true

require 'matrix'
require 'symbo'

module Quant
  class Qubit < Matrix
    include Symbo
    extend Symbo

    using Symbo

    def self.[](*state_or_value)
      rows = if state_or_value.length == 2
               state_or_value
             elsif state_or_value == ['0']
               [1, 0]
             elsif state_or_value == ['1']
               [0, 1]
             elsif state_or_value == ['+']
               [1/√(2), 1/√(2)]
             elsif state_or_value == ['-']
               [1/√(2), -1/√(2)]
             elsif state_or_value == ['i']
               [1/√(2), 1i/√(2)]
             elsif state_or_value == ['-i']
               [1/√(2), -1i/√(2)]
             else
               raise "Invalid qubit state: #{state_or_value}"
             end
      super(*rows.map { |each| [each.simplify] })
    end

    def -@
      map { |each| Product[-1, each].simplify }
    end

    def +(other)
      super(other).map(&:simplify)
    end

    def -(other)
      raise unless other.is_a?(Qubit) && row_size == other.row_size

      rows = (0...row_size).map do |each|
        Sum[self[each, 0], Product[-1, other[each, 0]]].simplify
      end
      Qubit[*rows]
    end

    def bra
      map(&:conjugate).t
    end

    def ket
      self
    end

    def state
      map(&:simplify)
    end

    def tensor_product(other)
      Matrix.build(4, 1) do |row, _col|
        if row < 2
          self[0] * other[row % 2]
        else
          self[1] * other[row % 2]
        end
      end
    end

    def to_s
      if self == Matrix[[1], [0]]
        '|0>'
      elsif self == Matrix[[0], [1]]
        '|1>'
      end
    end
  end
end
