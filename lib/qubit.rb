# frozen_string_literal: true

require 'cnot'
require 'h'
require 'matrix'
require 'r'
require 's'
require 't'
require 'z'

# 量子ビット
class Qubit
  include CNOT
  include H
  include R
  include S
  include T
  include Z

  attr_accessor :state

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

  def to_s
    if @state == [1, 0]
      '0'
    elsif @state == [0, 1]
      '1'
    end
  end
end
