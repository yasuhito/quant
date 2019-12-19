# frozen_string_literal: true

# ローテーションゲート Y
class RyGate
  include Math

  def initialize(qubits)
    @qubits = qubits.dup
  end

  def apply(target, theta)
    @qubits.tap do |qs|
      qs[target].state = (matrix(theta) * qs[target].ket.t).column_vectors[0].to_a
    end
  end

  private

  def matrix(theta)
    Matrix[[cos(theta / 2), -1 * sin(theta / 2)], [sin(theta / 2), cos(theta / 2)]]
  end
end
