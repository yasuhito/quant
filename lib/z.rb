# frozen_string_literal: true

# パウリ Z ゲート
module Z
  def z(target)
    matrix = Matrix[[1, 0], [0, -1]]
    @qubits[target].state = (matrix * @qubits[target].ket.t).column_vectors[0].to_a
  end
end
