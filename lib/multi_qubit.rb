# frozen_string_literal: true

require 'matrix'

# 量子ビット列
class MultiQubit
  def self.[](*qubit_state)
    new(*qubit_state)
  end

  def initialize(*qubit_state)
    @qubit_state = qubit_state
  end

  def *(other)
    (bra * other.ket.t)[0, 0]
  end

  def bra
    Matrix[@qubit_state.map(&:conj)]
  end

  def ket
    Matrix[@qubit_state]
  end

  def [](index)
    @qubit_state[index]
  end

  def to_s
    "|#{@qubit_state.join}>"
  end

  def to_a
    @qubit_state
  end

  def ==(other)
    to_a == other.to_a
  end

  def length
    @qubit_state.length
  end
end
