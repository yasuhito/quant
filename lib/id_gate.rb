# frozen_string_literal: true

# 単位行列
class IdGate
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
    Matrix.I(2)
  end
end
