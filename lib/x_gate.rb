# frozen_string_literal: true

# Pauli-X gate
class Xgate
  def initialize(qubits)
    @qubits = qubits.dup
  end

  def apply(target)
    @qubits.tap do |qs|
      qs[target].state = (matrix * qs[target].ket.t).column_vectors[0].to_a
    end
  end

  private

  def matrix
    Matrix[[0, 1], [1, 0]]
  end
end
