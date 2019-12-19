# frozen_string_literal: true

# フェーズシフトゲート S
module S
  def s(target)
    matrix = Matrix[[1, 0], [0, Complex(0, 1)]]
    @qubits[target].state = (matrix * @qubits[target].ket.t).column_vectors[0].to_a
  end
end