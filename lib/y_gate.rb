# frozen_string_literal: true

# Pauli-Y ゲート
class YGate
  def apply(qubits, target)
    qubits.dup.tap do |qs|
      qs[target].state = (matrix * qs[target].ket.t).column_vectors[0].to_a
    end
  end

  private

  def matrix
    Matrix[[0, -1i], [1i, 0]]
  end
end
