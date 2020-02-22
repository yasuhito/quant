# frozen_string_literal: true

require 'matrix'
require 'symbo'

module Quant
  class Qubit < Matrix
    include Symbo
    extend Symbo

    using Symbo

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
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
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

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

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def to_s
      return '|0>' if self == Matrix[[1], [0]]
      return '|1>' if self == Matrix[[0], [1]]

      coefficient0 = if self[0, 0].length == 1
                       self[0, 0].to_s
                     elsif self[0, 0].length > 1 && !self[0, 0].product?
                       "(#{self[0, 0]})"
                     elsif self[0, 0].product? && self[0, 0].operand(0) == -1 && self[0, 0].length > 2
                       "(#{self[0, 0]})"
                     elsif self[0, 0].product? && self[0, 0].operand(0) == -1 && self[0, 0].length == 2
                       (self[0, 0]).to_s
                     end

      operator = if self[1, 0].product? && self[1, 0].operand(0) == -1
                   '-'
                 else
                   '+'
                 end

      coefficient1 = if self[1, 0].length == 1
                       self[1, 0].to_s
                     elsif self[1, 0].length > 1 && !self[1, 0].product?
                       "(#{self[1, 0]})"
                     elsif self[1, 0].product? && self[1, 0].operand(0) != -1 && self[1, 0].length > 1
                       self[1, 0].to_s
                     elsif self[1, 0].product? && self[1, 0].operand(0) == -1 && self[1, 0].length > 2
                       "(#{self[1, 0].to_s[1..-1]})"
                     elsif self[1, 0].product? && self[1, 0].operand(0) == -1 && self[1, 0].length == 2
                       self[1, 0].to_s[1..-1].to_s
                     end

      "#{coefficient0}|0> #{operator} #{coefficient1}|1>"
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity
  end
end
