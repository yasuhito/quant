# frozen_string_literal: true

# フェーズシフトゲート S
class SGate
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
    Matrix[[1, 0], [0, 1i]]
  end
end
