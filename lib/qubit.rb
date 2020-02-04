# frozen_string_literal: true

require 'matrix'
require 'symbo'

# 量子ビット
class Qubit
  using Symbo

  def self.[](*state_or_value)
    if state_or_value.length == 2
      new(*state_or_value)
    elsif state_or_value == [0]
      new 1, 0
    elsif state_or_value == [1]
      new 0, 1
    elsif state_or_value == ['+']
      new 1 / Sqrt(2), 1 / Sqrt(2)
    elsif state_or_value == ['-']
      new 1 / Sqrt(2), -1 / Sqrt(2)
    elsif state_or_value == ['i']
      new 1 / Sqrt(2), 1i / Sqrt(2)
    elsif state_or_value == ['-i']
      new 1 / Sqrt(2), -1i / Sqrt(2)
    else
      raise
    end
  end

  def initialize(*state)
    @state = state
  end

  def *(other)
    if other.is_a?(Qubit)
      (bra * other.ket.t)[0, 0]
    else
      @state.map { |each| (each * other).simplify }
    end
  end

  def bra
    Matrix[@state.map(&:conj)]
  end

  def ket
    Matrix[@state]
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

  def state
    @state.map(&:simplify)
  end

  def [](index)
    @state[index]
  end

  def to_a
    @state
  end

  def ==(other)
    to_a == other.to_a
  end

  def to_s
    if @state == [1, 0]
      '0'
    elsif @state == [0, 1]
      '1'
    elsif @state == [1 / Sqrt(2), 1 / Sqrt(2)]
      '+'
    elsif @state == [1 / Sqrt(2), -1 / Sqrt(2)]
      '-'
    end
  end
end
