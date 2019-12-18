# frozen_string_literal: true

require 'matrix'

# 量子ビット列
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
