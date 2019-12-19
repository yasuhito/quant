# frozen_string_literal: true

# 量子回路
class Circuit
  def initialize(nqubits = 0, qubits = nil)
    @qubits = qubits || Qubits[*Array.new(nqubits, 0)]
  end

  def i(target)
    self.class.new nil, @qubits.i(target)
  end

  def x(target)
    self.class.new nil, @qubits.x(target)
  end

  def y(target)
    self.class.new nil, @qubits.y(target)
  end

  def z(target)
    self.class.new nil, @qubits.z(target)
  end

  def h(target)
    self.class.new nil, @qubits.h(target)
  end

  def s(target)
    self.class.new nil, @qubits.s(target)
  end

  def t(target)
    self.class.new nil, @qubits.t(target)
  end

  def rx(target, theta:)
    self.class.new nil, @qubits.rx(target, theta)
  end

  def ry(target, theta:)
    self.class.new nil, @qubits.ry(target, theta)
  end

  def rz(target, theta:)
    self.class.new nil, @qubits.rz(target, theta)
  end

  def r1(target, theta:)
    self.class.new nil, @qubits.r1(target, theta)
  end

  def cnot(target, control:)
    self.class.new nil, @qubits.cnot(target, control: control)
  end

  def state
    @qubits.state
  end

  def to_s
    @qubits.to_s
  end
end
