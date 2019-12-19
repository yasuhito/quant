# frozen_string_literal: true

# パウリ Y ゲート
module Y
  def y(target)
    matrix = Matrix[[0, Complex(0, -1)], [Complex(0, 1), 0]]
    @qubits[target].state = (matrix * @qubits[target].ket.t).column_vectors[0].to_a
  end
end
