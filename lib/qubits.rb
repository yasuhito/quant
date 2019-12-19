# frozen_string_literal: true

require 'i'
require 'x'

# 量子ビット系
class Qubits
  include I
  include X

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
