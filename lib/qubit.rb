# frozen_string_literal: true

require 'matrix'

# 量子ビット
class Qubit
  def self.[](*state)
    new(*state)
  end

  def initialize(*state)
    @state = state
  end

  def *(other)
    (bra * other.ket.t)[0, 0]
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

  def [](index)
    @state[index]
  end

  def to_a
    @state
  end

  def ==(other)
    to_a == other.to_a
  end
end
