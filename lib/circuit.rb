# frozen_string_literal: true

# 量子回路
class Circuit
  def initialize(nqubits)
    @qubits = Qubits[*Array.new(nqubits, 0)] # rubocop:disable Lint/RedundantSplatExpansion
  end

  def i(target)
    @qubits = @qubits.i(target)
    self
  end

  def x(target)
    @qubits = @qubits.x(target)
    self
  end

  def y(target)
    @qubits = @qubits.y(target)
    self
  end

  def z(target)
    @qubits = @qubits.z(target)
    self
  end

  def h(target)
    @qubits = @qubits.h(target)
    self
  end

  def s(target)
    @qubits = @qubits.s(target)
    self
  end

  def t(target)
    @qubits = @qubits.t(target)
    self
  end

  def rx(target, theta)
    @qubits = @qubits.rx(target, theta)
    self
  end

  def ry(target, theta)
    @qubits.ry(target, theta)
    self
  end

  def rz(target, theta)
    @qubits.rz(target, theta)
    self
  end

  def r1(target, theta)
    @qubits.r1(target, theta)
    self
  end

  def cnot(control:, target:)
    @qubits.cnot(control: control, target: target)
    self
  end

  def state
    @qubits.state
  end

  def to_s
    @qubits.to_s
  end
end
