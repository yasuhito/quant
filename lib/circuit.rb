# frozen_string_literal: true

require 'cnot_gate'
require 'h_gate'
require 'id_gate'
require 'qubit'
require 'r1_gate'
require 'rx_gate'
require 'ry_gate'
require 'rz_gate'
require 's_gate'
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
    self.class.new nil, RxGate.new(theta).apply(@qubits, target)
  end

  def ry(target, theta:)
    self.class.new nil, RyGate.new(theta).apply(@qubits, target)
  end

  def rz(target, theta:)
    self.class.new nil, RzGate.new(theta).apply(@qubits, target)
  end

  def r1(target, theta:)
    self.class.new nil, R1Gate.new(theta).apply(@qubits, target)
  end

  def cnot(target, control:)
    self.class.new nil, CnotGate.new.apply(@qubits, target, control)
  end

  def state
    @qubits.map(&:state)
  end

  def to_s
    "|#{@qubits.map(&:to_s).join}>"
  end
end
