# frozen_string_literal: true

require 'cnot'
require 'h_gate'
require 'id_gate'
require 'r1_gate'
require 'rx_gate'
require 'ry_gate'
require 'rz_gate'
require 's'
require 't_gate'
require 'x_gate'
require 'y_gate'
require 'z_gate'

# 量子ビット系
class Qubits
  include CNOT

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

  def t(target)
    self.class.new(*TGate.new(@qubits).apply(target))
  end

  def rx(target, theta)
    self.class.new(*RxGate.new(@qubits).apply(target, theta))
  end

  def ry(target, theta)
    self.class.new(*RyGate.new(@qubits).apply(target, theta))
  end

  def rz(target, theta)
    self.class.new(*RzGate.new(@qubits).apply(target, theta))
  end

  def r1(target, theta)
    self.class.new(*R1Gate.new(@qubits).apply(target, theta))
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
