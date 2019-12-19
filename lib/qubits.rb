# frozen_string_literal: true

require 'cnot'
require 'h'
require 'i'
require 'r'
require 's'
require 't'
require 'x_gate'
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
  include Y
  include Z

  attr_reader :qubits

  def self.[](*qubits)
    new(*qubits)
  end

  # rubocop:disable Metrics/MethodLength
  def initialize(*qubits)
    @qubits = if qubits.first.is_a?(Qubit)
                qubits
              else
                qubits.map do |each|
                  if each.zero?
                    Qubit[1, 0]
                  else
                    Qubit[0, 1]
                  end
                end
              end
  end
  # rubocop:enable Metrics/MethodLength

  def x(target)
    self.class.new(*Xgate.new(@qubits).apply(target))
  end

  def [](index)
    @qubits[index]
  end

  def state
    @qubits.map(&:state)
  end

  def to_s
    "|#{@qubits.map(&:to_s).join}>"
  end
end
