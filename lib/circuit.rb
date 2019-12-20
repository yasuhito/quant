# frozen_string_literal: true

require 'cnot_gate'
require 'h_gate'
require 'id_gate'
require 'qubit'
require 'r1'
require 'rx'
require 'ry'
require 'rz'
require 's_gate'
require 'swap_gate'
require 't_gate'
require 'x_gate'
require 'y_gate'
require 'z_gate'

# 量子回路
class Circuit
  def initialize(nqubits = 0, qubits = nil)
    @qubits = qubits || Array.new(nqubits) { Qubit[1, 0] }
  end

  def i(target)
    self.class.new nil, IdGate.new.apply(@qubits, target)
  end

  def x(target)
    self.class.new nil, XGate.new.apply(@qubits, target)
  end

  def y(target)
    self.class.new nil, YGate.new.apply(@qubits, target)
  end

  def z(target)
    self.class.new nil, ZGate.new.apply(@qubits, target)
  end

  def h(target)
    self.class.new nil, HGate.new.apply(@qubits, target)
  end

  def s(target)
    self.class.new nil, SGate.new.apply(@qubits, target)
  end

  def t(target)
    self.class.new nil, TGate.new.apply(@qubits, target)
  end

  def rx(target, theta:)
    self.class.new nil, Rx.new(theta).apply(@qubits, target)
  end

  def ry(target, theta:)
    self.class.new nil, Ry.new(theta).apply(@qubits, target)
  end

  def rz(target, theta:)
    self.class.new nil, Rz.new(theta).apply(@qubits, target)
  end

  def r1(target, theta:)
    self.class.new nil, R1.new(theta).apply(@qubits, target)
  end

  def cnot(target, control:)
    self.class.new nil, CnotGate.new.apply(@qubits, target, control)
  end

  def swap(qubit1, qubit2)
    self.class.new nil, SwapGate.new.apply(@qubits, qubit1, qubit2)
  end

  def state
    @qubits.map(&:state)
  end

  # rubocop:disable Metrics/AbcSize
  def controlled(gate, target, control:)
    return dup if @qubits[control] == Qubit[0]

    matrix = Matrix.hstack(Matrix.vstack(Matrix.I(2), Matrix.build(2) { 0 }),
                           Matrix.vstack(Matrix.build(2) { 0 }, gate.matrix))
    qs = @qubits[control].tensor_product(@qubits[target])
    result = matrix * qs
    qubits = @qubits.dup.tap do |obj|
      obj[target] = Qubit[result[2, 0], result[3, 0]]
    end
    self.class.new nil, qubits
  end
  # rubocop:enable Metrics/AbcSize

  def negate
    self.class.new nil, @qubits.map(&:negate)
  end

  def to_s
    "|#{@qubits.map(&:to_s).join}>"
  end
end
