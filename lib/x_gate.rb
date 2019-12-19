# frozen_string_literal: true

# Pauli-X gate
class XGate
  def apply(qubits, target)
    qubits.dup.tap do |qs|
      qs[target].state = (matrix * qs[target].ket.t).column_vectors[0].to_a
    end
  end

  private

  def matrix
    Matrix[[0, 1], [1, 0]]
  end
end
