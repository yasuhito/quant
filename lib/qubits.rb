# frozen_string_literal: true

require 'cnot'
require 'h'
require 'i'
require 'r'
require 's'
require 't'
require 'x'
require 'y'
require 'z'

# 量子ビット系
class Qubits
  include CNOT
  include H
  include I
  include R
  include S
  include T
  include X
  include Y
  include Z

  def self.[](*qubits)
    new(*qubits)
  end

  def initialize(*qubits)
    @qubits = qubits.map do |each|
      if each.zero?
        Qubit[1, 0]
      else
        Qubit[0, 1]
      end
    end
  end

  def [](index)
    @qubits[index]
  end

  def to_s
    "|#{@qubits.map(&:to_s).join}>"
  end
end
