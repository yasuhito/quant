# frozen_string_literal: true

require 'cnot'
require 'h_gate'
require 'id_gate'
require 'r'
require 's'
require 't'
require 'x_gate'
require 'y_gate'
require 'z_gate'

# 量子ビット系
class Qubits
  include CNOT
  include R
  include T

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

  def i(target)
    self.class.new(*IdGate.new(@qubits).apply(target))
  end

  def x(target)
    self.class.new(*XGate.new(@qubits).apply(target))
  end

  def y(target)
    self.class.new(*YGate.new(@qubits).apply(target))
  end

  def z(target)
    self.class.new(*ZGate.new(@qubits).apply(target))
  end

  def h(target)
    self.class.new(*HGate.new(@qubits).apply(target))
  end

  def s(target)
    self.class.new(*SGate.new(@qubits).apply(target))
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
