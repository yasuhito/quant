# frozen_string_literal: true

# フェーズシフトゲート T
module T
  include Math

  def t(target)
    matrix = Matrix[[1, 0], [0, E**(1i * PI / 4)]]
    @qubits[target].state = (matrix * @qubits[target].ket.t).column_vectors[0].to_a
  end
end
